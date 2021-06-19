//
//  UIViewPropertyAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-17.
//

import UIKit

extension UIViewPropertyAnimator {
    
    typealias Context = UIViewControllerContextTransitioning
    typealias Parameters = TransitionController.Parameters
    typealias Animator = UIViewPropertyAnimator

    static func present(using context: Context, duration: TimeInterval, snapshot: UIView, imageView: UIImageView, cellFrame: CGRect) -> Animator? {
        guard let toNavigationController = context.viewController(forKey: .to) as? NavigationController,
              let toViewController = toNavigationController.topViewController as? DetailViewController,
              let headerSnapshot = toViewController.tableView.tableHeaderView,
              let toView = context.view(forKey: .to)
        else { return nil }

        let containerView = context.containerView

        let animator = Animator(duration: duration, curve: .linear) {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                    snapshot.alpha = 1.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    let width = headerSnapshot.frame.width
                    let height = headerSnapshot.frame.height
                    imageView.frame = CGRect(x: 0, y: 90.0, width: width, height: height)
                    imageView.layer.cornerRadius = 40.0
                    snapshot.frame = context.finalFrame(for: toNavigationController)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                    imageView.alpha = 0.0
                }
            }
        }
        
        animator.addCompletion { _ in
            containerView.addSubview(toView)
            imageView.removeFromSuperview()
            snapshot.removeFromSuperview()
            context.completeTransition(!context.transitionWasCancelled)
        }

        return animator
    }
    
    static func dismiss(using context: Context, duration: TimeInterval, view: UIView, imageView: UIImageView, parameters: Parameters) -> Animator? {
        imageView.image = parameters.image
        imageView.alpha = 0.0
        context.containerView.addSubview(imageView)
        
        let frame = parameters.cellFrame
        
        let animator = Animator(duration: duration, dampingRatio: 0.8) {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                    imageView.alpha = 1.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    view.frame = frame
                    view.layer.cornerRadius =  20.0
                    
                    imageView.frame = frame
                    imageView.layer.cornerRadius = view.layer.cornerRadius
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
    
    static func cancel(using context: Context, duration: TimeInterval, view: UIView) -> Animator? {

        guard let fromView = context.view(forKey: .from),
              let toView = context.view(forKey: .to)
        else { return nil }
        
        let containerView = context.containerView
        
        let animator = Animator(duration: duration, dampingRatio: 0.8) {
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
}
