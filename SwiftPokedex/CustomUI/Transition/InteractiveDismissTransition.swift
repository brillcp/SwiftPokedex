//
//  InteractiveDismissTransition.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-17.
//

import UIKit

final class InteractiveDismissTransition: NSObject {

    // MARK: Private properties
    private var backgroundAnimation: UIViewPropertyAnimator? = nil
    private var transitionContext: UIViewControllerContextTransitioning? = nil

    private lazy var transitionImageView: UIView? = {
        let imageView = UIView()
        imageView.clipsToBounds = true
        return imageView
    }()

    private let params: TransitionController.Parameters

    // MARK: - Init
    init(params: TransitionController.Parameters) {
        self.params = params
        super.init()
    }

    // MARK: - Public functions
    func didPanWith(gestureRecognizer: UIPanGestureRecognizer) {
        guard let transitionContext = transitionContext else { return }
        
        let translation = gestureRecognizer.translation(in: nil)
        let translationVertical = translation.x

        // For a given vertical-drag, we calculate our percentage complete
        // and how shrunk-down the transition-image should be.
        let percentageComplete = self.percentageComplete(forVerticalDrag: translationVertical)
        let transitionImageScale = transitionImageScaleFor(percentageComplete: percentageComplete)

        switch gestureRecognizer.state {
        case .possible, .began:
            break
        case .cancelled, .failed:
            completeTransition(didCancel: true)

        case .changed:
            transitionImageView?.transform = CGAffineTransform.identity
                .scaledBy(x: transitionImageScale, y: transitionImageScale)
                .translatedBy(x: translation.x, y: translation.y)
            
            transitionContext.updateInteractiveTransition(percentageComplete)
            self.backgroundAnimation?.fractionComplete = percentageComplete

        case .ended:
            // Here, we decide whether to complete or cancel the transition.
            let fingerIsMovingDownwards = gestureRecognizer.velocity(in: nil).x > 0
            let transitionMadeSignificantProgress = percentageComplete > 0.1
            let shouldComplete = fingerIsMovingDownwards && transitionMadeSignificantProgress
            self.completeTransition(didCancel: !shouldComplete)
        @unknown default:
            break
        }
    }

    // MARK: - Private functions
    private func completeTransition(didCancel: Bool) {
        guard let transitionContext = transitionContext, let backgroundAnimation = backgroundAnimation else { return }
        
//        backgroundAnimation.addCompletion { _ in
//            self.transitionImageView?.removeFromSuperview()
//
//            transitionContext.finishInteractiveTransition()
//            transitionContext.completeTransition(true)
//
//            self.transitionContext = nil
//        }
        
        let completionDuration: Double
        let completionDamping: CGFloat
        
        if didCancel {
            completionDuration = 0.45
            completionDamping = 0.75
        } else {
            completionDuration = 0.37
            completionDamping = 0.90
        }

        let foregroundAnimation = UIViewPropertyAnimator(duration: completionDuration, dampingRatio: completionDamping) {
            self.transitionImageView?.transform = .identity
            self.transitionImageView?.frame = self.params.cellFrame
        }

        foregroundAnimation.addCompletion { [weak self] position in
            self?.transitionImageView?.removeFromSuperview()

            if didCancel {
                transitionContext.cancelInteractiveTransition()
            } else {
                transitionContext.finishInteractiveTransition()
            }
            transitionContext.completeTransition(!didCancel)
            self?.transitionContext = nil
        }

        let durationFactor = CGFloat(foregroundAnimation.duration / backgroundAnimation.duration)
        backgroundAnimation.continueAnimation(withTimingParameters: nil, durationFactor: durationFactor)
        foregroundAnimation.startAnimation()
    }

    private func percentageComplete(forVerticalDrag verticalDrag: CGFloat) -> CGFloat {
        let maximumDelta = CGFloat(200)
        return CGFloat.scaleAndShift(value: verticalDrag, inRange: (min: CGFloat(0), max: maximumDelta))
    }

    private func transitionImageScaleFor(percentageComplete: CGFloat) -> CGFloat {
        let minScale = CGFloat(0.68)
        let result = 1 - (1 - minScale) * percentageComplete
        return result
    }
}

// MARK: -
extension InteractiveDismissTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        fatalError("This is never called becuase the transition is interactive")
    }
}

extension InteractiveDismissTransition: UIViewControllerInteractiveTransitioning {

    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        
        backgroundAnimation = UIViewPropertyAnimator.dismissAnimator(from: transitionContext, params: params)
        
        if let fromViewController = transitionContext.viewController(forKey: .from) {
            transitionImageView = fromViewController.view.snapshotView(afterScreenUpdates: false)
            transitionImageView?.frame = transitionContext.finalFrame(for: fromViewController)
            containerView.addSubview(transitionImageView!)
        }
        
        if let nav = transitionContext.viewController(forKey: .from) as? NavigationController, let detail = nav.topViewController as? DetailViewController {
            detail.transitionController = self
        }
    }
}

extension CGFloat {
    /// Returns the value, scaled-and-shifted to the targetRange.
    /// If no target range is provided, we assume the unit range (0, 1)
    static func scaleAndShift(
        value: CGFloat,
        inRange: (min: CGFloat, max: CGFloat),
        toRange: (min: CGFloat, max: CGFloat) = (min: 0.0, max: 1.0)
        ) -> CGFloat {
        assert(inRange.max > inRange.min)
        assert(toRange.max > toRange.min)

        if value < inRange.min {
            return toRange.min
        } else if value > inRange.max {
            return toRange.max
        } else {
            let ratio = (value - inRange.min) / (inRange.max - inRange.min)
            return toRange.min + ratio * (toRange.max - toRange.min)
        }
    }
}
