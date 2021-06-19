//
//  DismissTransition.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-17.
//

import UIKit

final class DismissTransition: NSObject {

    // MARK: Private properties
    private var transitionContext: UIViewControllerContextTransitioning?
    private let parameters: TransitionController.Parameters

    private lazy var imageView: UIImageView = UIImageView.detailImageView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40.0
        view.clipsToBounds = true
        return view
    }()

    // MARK: - Init
    init(parameters: TransitionController.Parameters) {
        self.parameters = parameters
        super.init()
    }

    // MARK: - Public functions
    func didPan(with gesture: UIPanGestureRecognizer) {
        guard let transitionContext = transitionContext else { return }
        
        let translation = gesture.translation(in: nil)
        let progress = percentageComplete(for: translation.x)
        let scale = transitionScale(for: progress)
        
        switch gesture.state {
        case .changed:
            containerView.transform = CGAffineTransform.identity
                .scaledBy(x: scale, y: scale)
                .translatedBy(x: translation.x, y: translation.y)
            
            imageView.transform = containerView.transform
            transitionContext.updateInteractiveTransition(progress)
        case .ended:
            let fingerIsMovingDownwards = gesture.velocity(in: nil).x > 0
            let transitionMadeSignificantProgress = progress > 0.7
            let shouldComplete = fingerIsMovingDownwards && transitionMadeSignificantProgress
            completeTransition(didCancel: !shouldComplete)
        case .cancelled, .failed:
            completeTransition(didCancel: true)
        default:
            break
        }
    }

    // MARK: - Private functions
    private func completeTransition(didCancel: Bool) {
        guard let transitionContext = transitionContext else { return }

        let animator: UIViewPropertyAnimator?
        let duration: TimeInterval = transitionDuration(using: transitionContext)
        
        if didCancel {
            animator = .cancel(using: transitionContext, duration: duration, view: containerView)
        } else {
            animator = .dismiss(using: transitionContext,
                                        duration: duration,
                                        view: containerView,
                                        imageView: imageView,
                                        parameters: parameters)
        }
        
        animator?.startAnimation()
    }

    private func percentageComplete(for horizontalDrag: CGFloat) -> CGFloat {
        CGFloat.scaleAndShift(value: horizontalDrag, inRange: (min: 0.0, max: 100.0))
    }

    private func transitionScale(for percentage: CGFloat) -> CGFloat {
        1 - (1 - 0.94) * percentage
    }
}

// MARK: -
extension DismissTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        fatalError("This is never called becuase the transition is interactive")
    }
}

// MARK: -
extension DismissTransition: UIViewControllerInteractiveTransitioning {

    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from),
              let snapshot = fromView.snapshotView(afterScreenUpdates: false)
        else { return }

        self.transitionContext = transitionContext
        
        let contextView = transitionContext.containerView
        contextView.addSubview(toView)

        containerView = snapshot
        contextView.addSubview(containerView)

        imageView.frame = CGRect(x: 0, y: 90, width: fromView.frame.width, height: 310)
                
        guard let nav = transitionContext.viewController(forKey: .from) as? NavigationController,
              let detailView = nav.topViewController as? DetailViewController
        else { return }
        
        detailView.transitionController = self
    }
}
