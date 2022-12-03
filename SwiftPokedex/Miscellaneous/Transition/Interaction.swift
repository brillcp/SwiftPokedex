//
//  TransitionInteraction.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-20.
//

import UIKit

extension Transition {
    /// An interaction controller object that handles the interaction for the custom transition
    final class Interaction: NSObject {
        // MARK: Private properties
        private weak var transitionContext: UIViewControllerContextTransitioning?
        private weak var viewController: PresentableView?
        private let cell: UICollectionViewCell

        private var interactionDistance: CGFloat = 0.0
        private var transitionProgress: CGFloat = 0.0
        private let animDuration: TimeInterval = 0.3

        // MARK: - Public properties
        var interactionInProgress: Bool = false
        var initialFrame: CGRect
        var image: UIImage?

        // MARK: - Init
        /// Init the `InteractionController`
        /// - parameters:
        ///     - viewController: The presentable view controller
        ///     - cell: The collection view cell to start the transition from
        ///     - image: An optional image used in the custom transition
        init(viewController: PresentableView, cell: UICollectionViewCell, image: UIImage?) {
            self.viewController = viewController
            self.cell = cell

            let cellFrame = cell.layer.presentation()?.frame ?? .zero
            let convertedFrame = cell.superview?.convert(cellFrame, to: nil) ?? .zero
            self.initialFrame = convertedFrame
            self.image = image

            super.init()

            let gesture = HorizontalPanGesture(target: self, action: #selector(handlePan))
            viewController.view.addGestureRecognizer(gesture)
        }

        // MARK: - Private functions
        private func updateTransition(progress: CGFloat, translation: CGPoint) {
            guard let transitionContext = transitionContext,
                  let fromViewController = transitionContext.viewController(forKey: .from),
                  let fromView = fromViewController.view
            else { return }

            transitionContext.updateInteractiveTransition(progress)

            let scale = 1.0 - (1.0 - 0.93) * progress
            let multiplier: CGFloat = 7.0
            let rubberDistanceX = translation.x > 0 ? CGFloat(sqrt(translation.x) * multiplier) : 0.0
            let rubberDistanceY = translation.y > 0 ? CGFloat(sqrt(translation.y) * multiplier) : 0.0

            fromView.transform = CGAffineTransform.identity
                .scaledBy(x: scale, y: scale)
                .translatedBy(x: rubberDistanceX, y: rubberDistanceY)

            if let presentation = fromViewController.presentationController as? Presentation {
                presentation.setAlpha(Presentation.finalAlpha)
            }

            transitionProgress = progress
        }

        private func finishTransition(initialVelocity velocity: CGFloat) {
            guard let transitionContext = transitionContext,
                  let fromViewController = transitionContext.viewController(forKey: .from) as? PresentableView,
                  let fromView = fromViewController.view,
                  let snapshot = fromView.snapshotView(afterScreenUpdates: false),
                  let receivingFrame = fromViewController.receivingFrame
            else { return }

            fromView.isHidden = true
            let containerView = transitionContext.containerView
            snapshot.clipsToBounds = true
            snapshot.layer.cornerRadius = PokedexCell.CornerRadius.large
            snapshot.transform = fromView.transform
            containerView.addSubview(snapshot)

            var newRect = receivingFrame
            newRect.size.height += receivingFrame.height / 2

            let headerView = Transition.Animator.Header(frame: newRect, image: image, cornerRadius: PokedexCell.CornerRadius.large)
            headerView.transform = fromView.transform
            containerView.addSubview(headerView)

            let imageView = Transition.Animator.Image(frame: newRect, image: image)
            imageView.transform = fromView.transform
            containerView.addSubview(imageView)

            imageView.frame.size = imageView.size(fromMultiplier: 0.55)
            imageView.center = CGPoint(x: newRect.midX, y: newRect.midY + 50.0)

            let animator: UIViewPropertyAnimator = .springAnimator(duration: animDuration, initialVelocity: min(0.0, velocity))

            animator.addAnimations {
                headerView.alpha = 1.0
                imageView.alpha = 1.0
                imageView.frame = self.initialFrame.imageInset()
                headerView.layer.cornerRadius = PokedexCell.CornerRadius.small
                headerView.frame = self.initialFrame

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    if let presentation = fromViewController.presentationController as? Presentation {
                        presentation.setAlpha(0.0)
                    }
                }
                snapshot.frame = self.initialFrame
            }

            animator.addCompletion { _ in
                transitionContext.finishInteractiveTransition()
                transitionContext.completeTransition(true)
                self.interactionInProgress = false
                self.cell.isHidden = false
            }

            animator.startAnimation()
        }

        private func gestureCancelled(translation: CGFloat, velocity: CGFloat) {
            guard let transitionContext = transitionContext,
                  let fromView = transitionContext.viewController(forKey: .from)
            else { return }

            let animator: UIViewPropertyAnimator = .springAnimator(duration: animDuration, initialVelocity: velocity)
            animator.addAnimations {
                fromView.view.transform = .identity
            }

            animator.addCompletion { _ in
                transitionContext.cancelInteractiveTransition()
                transitionContext.completeTransition(false)
                self.interactionInProgress = false
            }

            animator.startAnimation()
        }

        private func spring(withVelocity velocity: CGFloat, forDistance distance: CGFloat) -> CGFloat {
            velocity / distance
        }
    }
}

// MARK: - InteractableTransition delegate
extension Transition.Interaction: InteractableTransition {

    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewController(forKey: .from) else { return }
        fromView.view.layer.cornerRadius = PokedexCell.CornerRadius.large
        self.transitionContext = transitionContext
        interactionDistance = 210
    }
}

// MARK: - Gestures
extension Transition.Interaction {

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let superview = gesture.view else { return }

        let translation = gesture.translation(in: superview)
        let velocity = gesture.velocity(in: superview).x
        let interruptedTranslation: CGFloat = 50.0

        switch gesture.state {
        case .began: beginGesture()
        case .changed: gestureChanged(translation: translation)
        case .cancelled: gestureCancelled(translation: translation.x + interruptedTranslation, velocity: velocity)
        case .ended: gestureEnded(translation: translation.x + interruptedTranslation, velocity: velocity)
        default: break
        }
    }

    private func beginGesture() {
        guard !interactionInProgress else { return }

        interactionInProgress = true
        viewController?.dismiss(animated: true)
    }

    private func gestureChanged(translation: CGPoint) {
        let progress = CGFloat.scale(value: translation.x, xValue: 250.0)
        updateTransition(progress: progress, translation: translation)
    }

    private func gestureEnded(translation: CGFloat, velocity: CGFloat) {
        if transitionProgress >= 0.7 || velocity > 300.0 {
            let spring = spring(withVelocity: velocity, forDistance: interactionDistance - translation)
            finishTransition(initialVelocity: spring)
        } else {
            let spring = spring(withVelocity: velocity, forDistance: -translation)
            gestureCancelled(translation: translation, velocity: spring)
        }
    }
}

// MARK: -
fileprivate extension UIViewPropertyAnimator {
    /// A static function that creates a new view property animator with timing parameters
    /// - parameters:
    ///     - duration: The duration of the animation
    ///     - velocity: The initial velocity value
    /// - returns: A new animator with the configured timing parameters
    static func springAnimator(duration: TimeInterval, initialVelocity velocity: CGFloat) -> UIViewPropertyAnimator {
        let vector = CGVector(dx: -velocity, dy: -velocity)
        let timingParameters = UISpringTimingParameters(dampingRatio: 0.7, initialVelocity: vector)
        return UIViewPropertyAnimator(duration: duration, timingParameters: timingParameters)
    }
}
