//
//  ListInteractor.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit
import Combine
import Networking

protocol ItemListInteractable {
    /// Download items from the backend
    func loadItems()
}

// MARK: -
final class ItemListInteractor: ItemListInteractable {

    // MARK: Private properties
    private var cancellables = Set<AnyCancellable>()
    private let service: Network.Service
    private let router: ItemListRoutable

    // MARK: - Public properties
    weak var view: ItemListViewProtocol? { didSet { setupInteractionPublisher() } }

    // MARK: - Init
    init(router: ItemListRoutable, service: Network.Service) {
        self.router = router
        self.service = service
    }

    // MARK: - Public functions
    func loadItems() {
        let request = ItemRequest.items(limit: 420)
        try! service.request(request, logResponse: true)
            .flatMap { (response: APIResponse) in
                Publishers.Sequence<[APIItem], Error>(sequence: response.results)
                    .tryCompactMap { [weak self] output -> AnyPublisher<ItemDetails, Error>? in
                        guard let self = self else { return nil }
                        return try self.service.request(ItemDetailRequest.item(output.url.asURL().lastPathComponent))
                    }
                    .flatMap { $0 }
                    .collect()
            }
            .sink { [weak self] result in
                switch result {
                case .success(let items):
                    self?.view?.viewModel.categories = items.categories
                case .failure(let error):
                    print(error.localizedDescription)
                    print()
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Private functions
    private func setupInteractionPublisher() {
        view?.interaction.sink { [weak self] interaction in
            switch interaction {
            case .selectItem(let item):
                self?.router.routeToItemList(with: item)
            }
        }.store(in: &cancellables)
    }
}
