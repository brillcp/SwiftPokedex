//
//  InteractionController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-20.
//

import UIKit

protocol InteractableTransition: UIViewControllerInteractiveTransitioning {
    var interactionInProgress: Bool { get }
    var initialFrame: CGRect { get }
    var image: UIImage? { get }
}

// MARK: -
protocol PresentableView: UIViewController {
    var transitionManager: UIViewControllerTransitioningDelegate? { get }
    var receivingFrame: CGRect? { get }
}

// MARK: -
final class InteractionController: NSObject, InteractableTransition {

    // MARK: Private properties
    private weak var transitionContext: UIViewControllerContextTransitioning?
    private weak var viewController: PresentableView?
    
    private var transitionProgress: CGFloat = 0.0
    private let animDuration: TimeInterval = 0.25
    
    // MARK: - Private properties
    var interactionInProgress: Bool = false
    var initialFrame: CGRect
    var image: UIImage?

    // MARK: - Init
    init(viewController: PresentableView, initialFrame: CGRect, image: UIImage?) {
        self.viewController = viewController
        self.initialFrame = initialFrame
        self.image = image
        
        super.init()
        
        let gesture = HorizontalPanGesture(target: self, action: #selector(handlePan))
        viewController.view.addGestureRecognizer(gesture)
    }
    
    // MARK: - Public functions
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        fromView.layer.cornerRadius = PokedexCell.CornerRadius.large
        self.transitionContext = transitionContext
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
        
        if let presentation = fromViewController.presentationController as? PresentationController {
            presentation.setAlpha(PresentationController.finalAlpha)
        }
        
        transitionProgress = progress
    }
    
    private func finishAnimation() {
        guard let transitionContext = transitionContext,
              let fromViewController = transitionContext.viewController(forKey: .from) as? PresentableView,
              let fromView = fromViewController.view,
              let snap = fromView.snapshotView(afterScreenUpdates: false),
              let receivingFrame = fromViewController.receivingFrame
        else { return }
        
        fromView.isHidden = true
        
        let containerView = transitionContext.containerView
        
        snap.clipsToBounds = true
        snap.layer.cornerRadius = PokedexCell.CornerRadius.large
        snap.transform = fromView.transform
        containerView.addSubview(snap)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 130.0, width: receivingFrame.width, height: receivingFrame.height))
        imageView.image = image
        imageView.alpha = 0.0
        imageView.transform = fromView.transform
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        
        UIView.animateKeyframes(withDuration: self.animDuration, delay: 0.0, options: .allowUserInteraction, animations: {
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
            self.interactionInProgress = false
        })
    }
    
    private func cancelAnimation() {
        guard let transitionContext = transitionContext,
              let fromViewController = transitionContext.viewController(forKey: .from),
              let fromView = fromViewController.view
        else { return }
        
        let cancelAnimator = UIViewPropertyAnimator(duration: animDuration, dampingRatio: 0.7) {
            fromView.layer.cornerRadius = 0.0
            fromView.transform = .identity
            
            if let presentation = fromViewController.presentationController as? PresentationController {
                presentation.setAlpha(PresentationController.finalAlpha)
            }
        }
        
        cancelAnimator.addCompletion { _ in
            transitionContext.cancelInteractiveTransition()
            transitionContext.completeTransition(false)
            self.interactionInProgress = false
            self.transitionProgress = 0.0
        }
        
        cancelAnimator.startAnimation()
    }
}

// MARK: -
extension InteractionController {

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let superview = gesture.view else { return }
        
        let translation = gesture.translation(in: superview)
        let velocity = gesture.velocity(in: superview).x
        
        switch gesture.state {
        case .began: beginGesture()
        case .changed: changeGesture(translation: translation)
        case .cancelled: cancelAnimation()
        case .ended: endGesture(translation: translation, velocity: velocity)
        default: break
        }
    }

    private func beginGesture() {
        guard !interactionInProgress else { return }
        
        interactionInProgress = true
        viewController?.dismiss(animated: true)
    }

    private func changeGesture(translation: CGPoint) {
        let progress = CGFloat.scale(value: translation.x, xValue: 250.0)
        updateTransition(progress: progress, translation: translation)
    }
    
    private func endGesture(translation: CGPoint, velocity: CGFloat) {
        if transitionProgress >= 0.7 || velocity > 300.0 {
            finishAnimation()
        } else {
            cancelAnimation()
        }
    }
}
