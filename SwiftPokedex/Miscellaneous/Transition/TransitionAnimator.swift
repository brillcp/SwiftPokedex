//
//  TransitionAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

/// An animation object for the custom interactive transition
final class TransitionAnimator: NSObject {

    // MARK: Private properties
    private let initialFrame: CGRect
    private let isPresenting: Bool
    private let image: UIImage?

    // MARK: - Init
    /// Init the `TransitionAnimator`
    /// - parameters:
    ///     - isPresenting: A boolean value that determine if the transition is being presented or dismissed
    ///     - interactionController: An interactable transition object used to make the custom transition interactable
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
        snap.alpha = 0.0
        containerView.addSubview(snap)

        let headerView = UIView(frame: initialFrame)
        headerView.layer.cornerRadius = PokedexCell.CornerRadius.small
        headerView.backgroundColor = image?.dominantColor
        headerView.alpha = 0.0
        containerView.addSubview(headerView)

        let imageView = UIImageView(frame: initialFrame.inset(by: .init(top: 0, left: 10, bottom: 15, right: 10)))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.alpha = 0.0
        containerView.addSubview(imageView)

        var newRect = receivingFrame
        newRect.size.height += receivingFrame.height / 2
        newRect.origin.y -= 10.0

        let newPoint: CGPoint = CGPoint(x: newRect.midX - 50.0, y: newRect.midY - 3.0)
        let multiplier: CGFloat = 1.7
        let newWidth: CGFloat = imageView.frame.size.width * multiplier
        let newHeight: CGFloat = imageView.frame.size.height * multiplier
        let newSize: CGSize = CGSize(width: newWidth, height: newHeight)

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.7) {
            UIView.animateKeyframes(withDuration: 0.0, delay: 0.0, options: .allowUserInteraction, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) {
                    headerView.alpha = 1.0
                    imageView.alpha = 1.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1) {
                    snap.alpha = 1.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                    headerView.layer.cornerRadius = PokedexCell.CornerRadius.large
                    headerView.frame = newRect
                    imageView.center = newPoint
                    imageView.frame.size = newSize
                }

                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                    snap.frame = transitionContext.finalFrame(for: toViewController)
                }
            })
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            headerView.removeFromSuperview()
            imageView.removeFromSuperview()
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

        var newRect = receivingFrame
        newRect.size.height += receivingFrame.height / 2
        newRect.origin.y -= 10.0

        let headerView = UIView(frame: newRect)
        headerView.layer.cornerRadius = PokedexCell.CornerRadius.large
        headerView.backgroundColor = image?.dominantColor
        headerView.alpha = 0.0
        containerView.addSubview(headerView)

        let imageView = UIImageView(frame: newRect)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.alpha = 0.0
        containerView.addSubview(imageView)

        let newPoint: CGPoint = CGPoint(x: newRect.midX, y: newRect.midY + 50.0)
        let multiplier: CGFloat = 0.55
        let newWidth: CGFloat = imageView.frame.size.width * multiplier
        let newHeight: CGFloat = imageView.frame.size.height * multiplier
        let newSize: CGSize = CGSize(width: newWidth, height: newHeight)

        imageView.frame.size = newSize
        imageView.center = newPoint

        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .allowUserInteraction, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) {
                headerView.alpha = 1.0
                imageView.alpha = 1.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                imageView.frame = self.initialFrame.inset(by: .init(top: 0, left: 10, bottom: 15, right: 10))
                headerView.layer.cornerRadius = PokedexCell.CornerRadius.small
                headerView.frame = self.initialFrame
            }

            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                snap.frame = self.initialFrame
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
        0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            presentAnimation(using: transitionContext)
        } else {
            dismissAnimation(using: transitionContext)
        }
    }
}
