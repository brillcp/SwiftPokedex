//
//  PresentTransition.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class PresentTransition: NSObject {

    // MARK: Private properties
    private let parameters: TransitionController.Parameters
    
    // MARK: - Init
    init(parameters: TransitionController.Parameters) {
        self.parameters = parameters
        super.init()
    }
}

// MARK: -
extension PresentTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let cellFrame = parameters.cellFrame
        
        guard let toView = transitionContext.view(forKey: .to),
              let snapshot = toView.snapshot(frame: cellFrame)
        else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(snapshot)
        
        let imageView = UIImageView.detailImageView(frame: cellFrame, image: parameters.image)
        containerView.addSubview(imageView)
                
        let animator = UIViewPropertyAnimator.present(using: transitionContext,
                                                              duration: transitionDuration(using: transitionContext),
                                                              snapshot: snapshot,
                                                              imageView: imageView,
                                                              cellFrame: cellFrame)
        animator?.startAnimation()
    }
}
