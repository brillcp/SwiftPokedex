//
//  PresentCardAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class PresentCardAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let params: Params

    struct Params {
        let fromCardFrame: CGRect
        let fromCell: PokedexCell
        let image: UIImage?
        let color: UIColor?
    }

    private let springAnimator: UIViewPropertyAnimator
    private var transitionDriver: PresentCardTransitionDriver?

    init(params: Params) {
        self.params = params
        self.springAnimator = UIViewPropertyAnimator.springAnimator()
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        springAnimator.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionDriver = PresentCardTransitionDriver(params: params, transitionContext: transitionContext, baseAnimator: springAnimator, image: params.image, color: params.color)
        transitionDriver?.animator.startAnimation()
    }

    func animationEnded(_ transitionCompleted: Bool) {
        transitionDriver = nil
    }
}

final class PresentCardTransitionDriver {
    
    let animator: UIViewPropertyAnimator
    
    init(params: PresentCardAnimator.Params, transitionContext: UIViewControllerContextTransitioning, baseAnimator: UIViewPropertyAnimator, image: UIImage?, color: UIColor?) {
        let context = transitionContext
        let container = context.containerView
        let fromCardFrame = params.fromCardFrame
        
        let toViewController = context.viewController(forKey: .to)!
        let tt = toViewController.view!
        
        let toView = tt.snapshotView(afterScreenUpdates: true)!
        toView.frame = fromCardFrame
        toView.layer.cornerRadius = 20.0
        toView.clipsToBounds = true
        toView.alpha = 0.0
        container.addSubview(toView)
        
        var imageFrame = fromCardFrame
        imageFrame.size.height -= 35.0
        let imageView = UIImageView(frame: imageFrame)
        imageView.layer.cornerRadius = toView.layer.cornerRadius
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = color
        imageView.image = image
        container.addSubview(imageView)
        
        let final = context.finalFrame(for: toViewController)
        
        baseAnimator.addAnimations {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                    toView.alpha = 1.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    imageView.frame = CGRect(x: 0, y: 90.0, width: final.width, height: 300.0)
                    imageView.layer.cornerRadius = 40.0
                    toView.frame = final
                }
            }
        }

        baseAnimator.addCompletion { _ in
            imageView.removeFromSuperview()
            toView.removeFromSuperview()
            container.addSubview(tt)
            context.completeTransition(!context.transitionWasCancelled)
        }
        self.animator = baseAnimator
    }
}

extension UIViewPropertyAnimator {
    static func springAnimator() -> UIViewPropertyAnimator {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.2, initialVelocity: CGVector(dx: 0.0, dy: 0.7))
        return UIViewPropertyAnimator(duration: 2.0, timingParameters: springTiming)
    }
}
