//
//  TransitionAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class TransitionAnimator: NSObject {

    // MARK: Private properties
    private let initialFrame: CGRect
    private let image: UIImage?
    private let isPresenting: Bool

    // MARK: - Init
    init(isPresenting: Bool, interactionController: InteractableTransition) {
        self.initialFrame = interactionController.initialFrame
        self.image = interactionController.image
        self.isPresenting = isPresenting
        super.init()
    }

    // MARK: - Private functions
    private func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) as? PresentableView,
              let toView = toViewController.view,
              let snap = toView.snapshotView(afterScreenUpdates: true),
              let receivingFrame = toViewController.receivingFrame
        else { return }

        let containerView = transitionContext.containerView

        toView.isHidden = true
        containerView.addSubview(toView)

        snap.clipsToBounds = true
        snap.layer.cornerRadius = PokedexCell.CornerRadius.large
        snap.frame = initialFrame
        containerView.addSubview(snap)

        let headerView = UIView(frame: initialFrame)
        headerView.layer.cornerRadius = PokedexCell.CornerRadius.small
        headerView.backgroundColor = image?.dominantColor
        containerView.addSubview(headerView)

        let imageView = UIImageView(frame: initialFrame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        containerView.addSubview(imageView)

        var newRect = receivingFrame
        newRect.size.height += receivingFrame.height / 2

        let newPoint: CGPoint = CGPoint(x: newRect.midX - 60.0, y: newRect.midY)
        let multiplier: CGFloat = 1.7
        let newWidth: CGFloat = imageView.frame.size.width * multiplier
        let newHeight: CGFloat = imageView.frame.size.height * multiplier
        let newSize: CGSize = CGSize(width: newWidth, height: newHeight)

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.7) {
            UIView.animateKeyframes(withDuration: 0.0, delay: 0.0, options: .allowUserInteraction, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.8) {
                    headerView.layer.cornerRadius = PokedexCell.CornerRadius.large
                    headerView.frame = newRect
                    imageView.center = newPoint
                    imageView.frame.size = newSize
                }

                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                    headerView.alpha = 0.0
                    imageView.alpha = 0.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.8) {
                    snap.frame = transitionContext.finalFrame(for: toViewController)
                }
            })
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            headerView.removeFromSuperview()
            snap.removeFromSuperview()
            toView.isHidden = false
        }

        animator.startAnimation()
    }
    
    private func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? PresentableView,
              let fromView = fromViewController.view,
              let snap = fromView.snapshotView(afterScreenUpdates: false),
              let receivingFrame = fromViewController.receivingFrame
        else { return }

        let containerView = transitionContext.containerView

        fromView.isHidden = true
        snap.clipsToBounds = true
        snap.layer.cornerRadius = PokedexCell.CornerRadius.large
        containerView.addSubview(snap)

        let imageView = UIImageView(frame: CGRect(x: 0, y: 130.0, width: receivingFrame.width, height: receivingFrame.height))
        imageView.image = image
        imageView.alpha = 0.0
        imageView.transform = fromView.transform
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)

        let duration = transitionDuration(using: transitionContext)

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .allowUserInteraction, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                imageView.alpha = 1.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.9) {
                imageView.frame = self.initialFrame
                snap.frame = self.initialFrame
                snap.layer.cornerRadius = PokedexCell.CornerRadius.small

                if let presentation = fromViewController.presentationController as? PresentationController {
                    presentation.setAlpha(0.0)
                }
            }

            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                snap.alpha = 0.0
            }
        }, completion: { _ in
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(true)
        })
    }
}

// MARK: -
extension TransitionAnimator: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.25
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            presentAnimation(using: transitionContext)
        } else {
            dismissAnimation(using: transitionContext)
        }
    }
}
