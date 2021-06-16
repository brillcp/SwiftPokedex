//
//  CardTransition.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class CardTransition: NSObject, UIViewControllerTransitioningDelegate {
    struct Params {
        let fromCardFrame: CGRect
        let fromCardFrameWithoutTransform: CGRect
        let fromCell: PokedexCell
        let image: UIImage?
        let color: UIColor?
    }

    let params: Params

    init(params: Params) {
        self.params = params
        super.init()
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let params = PresentCardAnimator.Params(
            fromCardFrame: self.params.fromCardFrame,
            fromCell: self.params.fromCell,
            image: self.params.image,
            color: self.params.color
        )
        return PresentCardAnimator(params: params)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let params = DismissCardAnimator.Params(
            fromCardFrame: self.params.fromCardFrame,
            fromCardFrameWithoutTransform: self.params.fromCardFrameWithoutTransform,
            fromCell: self.params.fromCell,
            image: self.params.image,
            color: self.params.color
        )
        return DismissCardAnimator(params: params)
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }

    // IMPORTANT: Must set modalPresentationStyle to `.custom` for this to be used.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CardPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
