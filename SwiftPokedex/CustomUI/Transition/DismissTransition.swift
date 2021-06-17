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

    private lazy var transitionImageView: UIImageView = UIImageView.detailImageView(parameters: parameters)
    private lazy var transitionView: UIView = UIView()

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

        print(progress)
        
        switch gesture.state {
        case .changed:
            transitionView.transform = CGAffineTransform.identity
                .scaledBy(x: scale, y: scale)
                .translatedBy(x: translation.x, y: translation.y)
            
            transitionImageView.transform = transitionView.transform
            
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

        transitionContext.containerView.addSubview(self.transitionImageView)

        transitionImageView.alpha = 0.0
        
        let animator = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 0.8) {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    self.transitionImageView.alpha = 1.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    self.transitionView.frame = self.parameters.cellFrame
                    self.transitionView.layer.cornerRadius = 20.0
                    
                    var imageFrame = self.parameters.cellFrame
                    imageFrame.size.height -= 35

                    self.transitionImageView.frame = imageFrame
                    self.transitionImageView.layer.cornerRadius = 20.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1) {
                    self.transitionView.alpha = 0.0
                }
            }
        }

        animator.addCompletion { [weak self] position in
            self?.transitionView.removeFromSuperview()
            self?.transitionImageView.removeFromSuperview()

            if didCancel {
                transitionContext.cancelInteractiveTransition()
            } else {
                transitionContext.finishInteractiveTransition()
            }
            transitionContext.completeTransition(!didCancel)
            self?.transitionContext = nil
        }
        
        animator.startAnimation()
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

extension DismissTransition: UIViewControllerInteractiveTransitioning {

    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }

        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)

        if let fromViewController = transitionContext.viewController(forKey: .from) {
            transitionView = fromViewController.view.snapshotView(afterScreenUpdates: false) ?? UIView()
            transitionView.frame = transitionContext.finalFrame(for: fromViewController)
            transitionView.layer.cornerRadius = 40.0
            transitionView.clipsToBounds = true
            
            let width = transitionContext.view(forKey: .from)?.frame.width ?? 0.0
            let frame = CGRect(x: 0, y: 90, width: width, height: 310)
            transitionImageView.frame = frame
            
            containerView.addSubview(transitionView)
        }
        
        if let nav = transitionContext.viewController(forKey: .from) as? NavigationController, let detail = nav.topViewController as? DetailViewController {
            detail.transitionController = self
        }
    }
}

extension CGFloat {
    typealias Range = (min: CGFloat, max: CGFloat)
    
    static func scaleAndShift(value: CGFloat, inRange: Range, toRange: Range = (min: 0.0, max: 1.0)) -> CGFloat {
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
