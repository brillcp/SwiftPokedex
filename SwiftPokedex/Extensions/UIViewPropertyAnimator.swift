//
//  UIViewPropertyAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-17.
//

import UIKit

extension UIViewPropertyAnimator {

    static func presentAnimator( from transitionContext: UIViewControllerContextTransitioning, params: TransitionController.Parameters) -> UIViewPropertyAnimator {
        let context = transitionContext
        let container = context.containerView
        let fromCardFrame = params.cellFrame
        
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
        imageView.backgroundColor = params.color
        imageView.image = params.image
        container.addSubview(imageView)
        
        let final = context.finalFrame(for: toViewController)
        
        let animator = UIViewPropertyAnimator(duration: 0, curve: .linear) {
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

        animator.addCompletion { _ in
            imageView.removeFromSuperview()
            toView.removeFromSuperview()
            container.addSubview(tt)
            context.completeTransition(!context.transitionWasCancelled)
        }

        return animator
    }
    
    static func dismissAnimator(from transitionContext: UIViewControllerContextTransitioning, params: TransitionController.Parameters) -> UIViewPropertyAnimator {
        let context = transitionContext
        let container = context.containerView
        let fromCardFrame = params.cellFrame
        
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
        imageView.backgroundColor = params.color
        imageView.image = params.image
        container.addSubview(imageView)
        
        var imageFrame = fromCardFrame
        imageFrame.size.height -= 35
        
        let animator = UIViewPropertyAnimator(duration: 0, curve: .linear) {
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
        
        animator.addCompletion { _ in
            imageView.removeFromSuperview()
//            context.completeTransition(!context.transitionWasCancelled)
        }

        return animator
    }
}
