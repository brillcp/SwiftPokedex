//
//  TransitionAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

extension Transition {
    /// An animation object for the custom interactive transition
    final class Animator: NSObject {
        // MARK: Private properties
        private let cell: UICollectionViewCell
        private let initialFrame: CGRect
        private let isPresenting: Bool
        private let image: UIImage?

        // MARK: - Init
        /// Init the `TransitionAnimator`
        /// - parameters:
        ///     - isPresenting: A boolean value that determine if the transition is being presented or dismissed
        ///     - interactionController: An interactable transition object used to make the custom transition interactable
        init(isPresenting: Bool, interaction: InteractableTransition, cell: UICollectionViewCell) {
            self.initialFrame = interaction.initialFrame
            self.image = interaction.image
            self.isPresenting = isPresenting
            self.cell = cell
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

            let headerView = Header(frame: initialFrame, image: image, cornerRadius: PokedexCell.CornerRadius.small)
            containerView.addSubview(headerView)

            let imgFrame = initialFrame.imageInset()
            let imageView = Image(frame: imgFrame, image: image)
            containerView.addSubview(imageView)

            var newRect = receivingFrame
            newRect.size.height += receivingFrame.height / 2
            newRect.origin.y -= 10.0

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
                        imageView.center = CGPoint(x: newRect.midX - 50.0, y: newRect.midY - 3.0)
                        imageView.frame.size = imageView.size(fromMultiplier: 1.7)
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
                self.cell.isHidden = true
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

            let headerView = Header(frame: newRect, image: image, cornerRadius: PokedexCell.CornerRadius.large)
            containerView.addSubview(headerView)

            let imageView = Image(frame: newRect, image: image)
            containerView.addSubview(imageView)

            imageView.frame.size = imageView.size(fromMultiplier: 0.55)
            imageView.center = CGPoint(x: newRect.midX, y: newRect.midY + 50.0)

            let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.7) {
                UIView.animateKeyframes(withDuration: 0.0, delay: 0.0, options: .allowUserInteraction, animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) {
                        headerView.alpha = 1.0
                        imageView.alpha = 1.0
                    }

                    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                        imageView.frame = self.initialFrame.imageInset()
                        headerView.layer.cornerRadius = PokedexCell.CornerRadius.small
                        headerView.frame = self.initialFrame
                    }

                    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                        snap.frame = self.initialFrame
                    }
                })
            }

            animator.addCompletion { _ in
                transitionContext.finishInteractiveTransition()
                transitionContext.completeTransition(true)
                self.cell.isHidden = false
            }

            animator.startAnimation()
        }
    }
}

// MARK: -
extension Transition.Animator: UIViewControllerAnimatedTransitioning {

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
