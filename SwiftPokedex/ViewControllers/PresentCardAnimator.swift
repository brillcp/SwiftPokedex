//
//  PresentCardAnimator.swift
//  AppStoreInteractiveTransition
//
//  Created by Wirawit Rueopas on 31/7/18.
//  Copyright © 2018 Wirawit Rueopas. All rights reserved.
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

    private let presentAnimationDuration: TimeInterval
    private let springAnimator: UIViewPropertyAnimator
    private var transitionDriver: PresentCardTransitionDriver?

    init(params: Params) {
        self.params = params
        self.springAnimator = PresentCardAnimator.createBaseSpringAnimator(params: params)
        self.presentAnimationDuration = springAnimator.duration
        super.init()
    }

    private static func createBaseSpringAnimator(params: PresentCardAnimator.Params) -> UIViewPropertyAnimator {
        // Damping between 0.7 (far away) and 1.0 (nearer)
        let cardPositionY = params.fromCardFrame.minY
        let distanceToBounce = abs(params.fromCardFrame.minY)
        let extentToBounce = cardPositionY < 0 ? params.fromCardFrame.height : UIScreen.main.bounds.height
        let dampFactorInterval: CGFloat = 0.3
        let damping: CGFloat = 1.0 - dampFactorInterval * (distanceToBounce / extentToBounce)

        // Duration between 0.5 (nearer) and 0.9 (nearer)
        let baselineDuration: TimeInterval = 0.5
        let maxDuration: TimeInterval = 0.9
        let duration: TimeInterval = baselineDuration + (maxDuration - baselineDuration) * TimeInterval(max(0, distanceToBounce)/UIScreen.main.bounds.height)

        let springTiming = UISpringTimingParameters(dampingRatio: damping, initialVelocity: .init(dx: 0, dy: 0))
        return UIViewPropertyAnimator(duration: 1.5, timingParameters: springTiming)
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // 1.
        return presentAnimationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 2.
        transitionDriver = PresentCardTransitionDriver(params: params, transitionContext: transitionContext, baseAnimator: springAnimator, image: params.image, color: params.color)
        interruptibleAnimator(using: transitionContext).startAnimation()
    }

    func animationEnded(_ transitionCompleted: Bool) {
        // 4.
        transitionDriver = nil
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // 3.
        return transitionDriver!.animator
    }
}

final class PresentCardTransitionDriver {
    
    let animator: UIViewPropertyAnimator
    
    init(params: PresentCardAnimator.Params, transitionContext: UIViewControllerContextTransitioning, baseAnimator: UIViewPropertyAnimator, image: UIImage?, color: UIColor?) {
        let ctx = transitionContext
        let container = ctx.containerView

        var fromCardFrame = params.fromCardFrame
        
        fromCardFrame.size.height -= 35.0
                
        let fromFrame: CGRect = ctx.viewController(forKey: .from)?.view.frame ?? .zero
        let final = ctx.finalFrame(for: ctx.viewController(forKey: .to)!)
        
        let toView = ctx.view(forKey: .to)!
        toView.frame = final
        toView.frame.size.height = 0.0
        container.addSubview(toView)
        
        let imageView = UIImageView(frame: fromCardFrame)
        imageView.layer.cornerRadius = 20.0
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = color
        imageView.image = image
        container.addSubview(imageView)
        
        baseAnimator.addAnimations {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    imageView.frame = CGRect(x: 0, y: 0, width: fromFrame.width, height: 320.0)
                    imageView.layer.cornerRadius = 30.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    toView.frame.size.height = final.height
                }
            }
        }

        self.animator = baseAnimator
    }
}
