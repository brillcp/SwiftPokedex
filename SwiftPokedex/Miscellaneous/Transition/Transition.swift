//
//  Transition.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

/// A transition controller object used to present and dismiss the custom transition
final class Transition: NSObject {

    // MARK: Private properties
    private let interaction: InteractableTransition
    private let cell: UICollectionViewCell

    // MARK: - Init
    /// Init the `Transition`
    /// - parameters:
    ///     - interaction: An interactable transition object used to make the custom transition interactable
    ///     - cell: The given collection view cell that we want to transition from
    init(interaction: InteractableTransition, cell: UICollectionViewCell) {
        self.interaction = interaction
        self.cell = cell
        super.init()
    }
}

// MARK: -
extension Transition: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        Presentation(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Animator(isPresenting: true, interaction: interaction, cell: cell)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Animator(isPresenting: false, interaction: interaction, cell: cell)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard interaction.interactionInProgress else { return nil }
        return interaction
    }
}
