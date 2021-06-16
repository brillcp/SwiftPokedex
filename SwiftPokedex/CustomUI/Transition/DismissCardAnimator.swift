//
//  DismissCardAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class DismissCardAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    struct Params {
        let fromCardFrame: CGRect
        let fromCardFrameWithoutTransform: CGRect
        let fromCell: PokedexCell
        let image: UIImage?
        let color: UIColor?
    }

    struct Constants {
        static let relativeDurationBeforeNonInteractive: TimeInterval = 0.5
        static let minimumScaleBeforeNonInteractive: CGFloat = 0.8
    }

    private var transitionDriver: DismissTransitionDriver?
    private let springAnimator: UIViewPropertyAnimator
    private let params: Params

    init(params: Params) {
        self.params = params
        self.springAnimator = UIViewPropertyAnimator.springAnimator()
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        springAnimator.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionDriver = DismissTransitionDriver(params: params, transitionContext: transitionContext, baseAnimator: springAnimator, image: params.image, color: params.color)
        transitionDriver?.animator.startAnimation()
    }
}

final class DismissTransitionDriver {
    
    let animator: UIViewPropertyAnimator
    
    init(params: DismissCardAnimator.Params, transitionContext: UIViewControllerContextTransitioning, baseAnimator: UIViewPropertyAnimator, image: UIImage?, color: UIColor?) {
        let context = transitionContext
        let container = context.containerView
        let fromCardFrame = params.fromCardFrame
        
        let to = context.view(forKey: .to)!
        container.addSubview(to)
        
        let from = context.view(forKey: .from)!
        let snap = from.snapshotView(afterScreenUpdates: false)!
        snap.layer.cornerRadius = 40.0
        snap.clipsToBounds = true
        container.addSubview(snap)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 80, width: snap.frame.width, height: 310))
        imageView.layer.cornerRadius = snap.layer.cornerRadius
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = color
        imageView.image = image
        container.addSubview(imageView)
                
        var imageFrame = fromCardFrame
        imageFrame.size.height -= 35
        
        baseAnimator.addAnimations {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    snap.layer.cornerRadius = 20.0
                    snap.frame = fromCardFrame
                    imageView.frame = imageFrame
                    imageView.layer.cornerRadius = snap.layer.cornerRadius
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                    snap.alpha = 0.0
                }
            }
        }

        baseAnimator.addCompletion { _ in
            context.completeTransition(!context.transitionWasCancelled)
        }
        self.animator = baseAnimator
    }
}
