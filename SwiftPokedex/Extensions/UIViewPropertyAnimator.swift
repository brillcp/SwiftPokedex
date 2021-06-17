//
//  UIViewPropertyAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-17.
//

import UIKit

extension UIViewPropertyAnimator {

    typealias Parameters = TransitionController.Parameters
    typealias Context = UIViewControllerContextTransitioning

    static func presentAnimator(from context: Context, parameters: Parameters) -> UIViewPropertyAnimator? {
        guard let toViewController = context.viewController(forKey: .to),
              let toView = toViewController.view,
              let snapshot = toView.snapshot(frame: parameters.cellFrame)
        else { return nil }
        
        let container = context.containerView
        
        container.addSubview(snapshot)
        
        var imageFrame = snapshot.frame
        imageFrame.size.height -= 35.0
        let imageView = UIImageView.detailImageView(frame: imageFrame, parameters: parameters)
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
            container.addSubview(toView)
            context.completeTransition(!context.transitionWasCancelled)
        }

        return animator
    }
    
    static func dismissAnimator(from context: Context, params: Parameters) -> UIViewPropertyAnimator {
        let container = context.containerView
        let fromCardFrame = params.cellFrame
        
        let toView = context.view(forKey: .to)!
        container.addSubview(toView)
        
        var imageFrame = fromCardFrame
        imageFrame.size.height -= 35
        
        let animator = UIViewPropertyAnimator(duration: 0, curve: .linear) {
        }
        
        animator.addCompletion { _ in
        }

        return animator
    }
}

extension UIView {
    func snapshot(frame: CGRect) -> UIView? {
        let snapshot = snapshotView(afterScreenUpdates: true)
        snapshot?.frame = frame
        snapshot?.layer.cornerRadius = 20.0
        snapshot?.clipsToBounds = true
        snapshot?.alpha = 0.0
        return snapshot
    }
}

extension UIImageView {
    
    static func detailImageView(frame: CGRect, parameters: TransitionController.Parameters) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.layer.cornerRadius = 40.0
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = parameters.color
        imageView.image = parameters.image
        return imageView
    }
}
