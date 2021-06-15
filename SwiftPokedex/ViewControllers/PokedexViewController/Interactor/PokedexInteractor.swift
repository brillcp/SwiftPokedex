//
//  PokedexInteractor.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol PokedexInteractorProtocol {
    func selectPokemon(at indexPath: IndexPath, in collectionView: UICollectionView)
}

// MARK: -
final class PokedexInteractor: PokedexInteractorProtocol {
    
    // MARK: Private properties
    private let router: PokedexRouterProtocol
    
    // MARK: - Init
    init(router: PokedexRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Public functions
    func selectPokemon(at indexPath: IndexPath, in collectionView: UICollectionView) {
        guard let cell = collectionView.cell(at: indexPath) as? PokedexCell,
              let pokemon = cell.data,
              let color = cell.backgroundColor,
              let cellSuperview = cell.superview,
              let cellFrame = cell.layer.presentation()?.frame
        else { return }

        let cardPresentationFrameOnScreen = cellSuperview.convert(cellFrame, to: nil)
        
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let x = center.x - size.width / 2
            let y = center.y - size.height / 2
            let rect = CGRect(x: x, y: y, width: size.width, height: size.height)
            return cellSuperview.convert(rect, to: nil)
        }()
        
        print()
        
        // Get tapped cell location
//        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell

        // Freeze highlighted state (or else it will bounce back)
//        cell.freezeAnimations()

        // Get current frame on screen
//        let currentCellFrame = cell.layer.presentation()!.frame

        // Convert current frame to screen's coordinates
//        let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)

        // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
//        let cardFrameWithoutTransform = { () -> CGRect in
//            let center = cell.center
//            let size = cell.bounds.size
//            let r = CGRect(
//                x: center.x - size.width / 2,
//                y: center.y - size.height / 2,
//                width: size.width,
//                height: size.height
//            )
//            return cell.superview!.convert(r, to: nil)
//        }()

//        let cardModel = cardModels[indexPath.row]

        // Set up card detail view controller
//        let vc = storyboard!.instantiateViewController(withIdentifier: "cardDetailVc") as! CardDetailViewController
//        vc.cardViewModel = cardModel.highlightedImage()
//        vc.unhighlightedCardViewModel = cardModel // Keep the original one to restore when dismiss
        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                           fromCell: cell,
                                           image: cell.image,
                                           color: color)
        let transition = CardTransition(params: params)
//        vc.transitioningDelegate = transition

        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
//        vc.modalPresentationCapturesStatusBarAppearance = true
//        vc.modalPresentationStyle = .custom

//        present(vc, animated: true, completion: { [unowned cell] in
//            // Unfreeze
//            cell.unfreezeAnimations()
//        })

        router.routeToDetailView(transition: transition, pokemon: pokemon, color: color)
    }
}
