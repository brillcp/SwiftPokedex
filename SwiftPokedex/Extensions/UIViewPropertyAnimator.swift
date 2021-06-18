//
//  UIViewPropertyAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-17.
//

import UIKit

extension UIViewPropertyAnimator {
    
    typealias Context = UIViewControllerContextTransitioning
    
    static func cancelAnimator(from context: Context, view: UIView) -> UIViewPropertyAnimator? {

        guard let fromView = context.view(forKey: .from),
              let toView = context.view(forKey: .to)
        else { return nil }
        
        let containerView = context.containerView
        
        let animator = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 0.8) {
            view.transform = .identity
            view.frame = fromView.frame
        }

        animator.addCompletion { position in
            containerView.addSubview(toView)
            view.removeFromSuperview()
            context.cancelInteractiveTransition()
            context.completeTransition(true)
        }
        
        return animator
    }
    
    static func dismissAnimator(from context: Context, view: UIView, imageView: UIImageView, frame: CGRect) -> UIViewPropertyAnimator {
        
        imageView.alpha = 0.0
        
        let animator = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 0.8) {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    imageView.alpha = 1.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    view.frame = frame
                    view.layer.cornerRadius =  20.0
                    
                        context.containerView.addSubview(imageView)

                        var imageFrame = frame
                        imageFrame.size.height -= 35

                        imageView.frame = imageFrame
                        imageView.layer.cornerRadius = 20.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                    view.alpha = 0.0
                }
            }
        }

        animator.addCompletion { position in
            view.removeFromSuperview()
            imageView.removeFromSuperview()
            context.finishInteractiveTransition()
            context.completeTransition(true)
        }
        
        return animator
    }
}
