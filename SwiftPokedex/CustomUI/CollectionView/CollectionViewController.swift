//
//  CollectionViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    // MARK: Public properties
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .white
        return spinner
    }()

    var collectionData: UICollectionView.DataSource {
        didSet {
            registerCellsIfNeeded()
            collectionView.reloadData()
        }
    }
    
    // MARK: - Init
    init(layout: UICollectionViewLayout, tableData: UICollectionView.DataSource = .init()) {
        self.collectionData = tableData
        super.init(collectionViewLayout: layout)

        collectionView.registerReusableFooter(view: UICollectionReusableView.self)
        collectionView.delaysContentTouches = false
        collectionView.indicatorStyle = .white
        registerCellsIfNeeded()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Private functions
    private func registerCellsIfNeeded() {
        guard collectionData.hasData else { return }
        collectionData.cellTypes.forEach { collectionView.registerCell($0) }
    }
    
    // MARK: - TableView Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionData.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData.numberOfItems(in: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableView(ofKind: kind, at: indexPath)
        footer.addSubview(spinner)
        spinner.center = CGPoint(x: collectionView.center.x, y: footer.frame.height / 2.0)
        return footer
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionData.item(at: indexPath)
        let cell = collectionView.dequeueCell(for: item, at: indexPath)
        
        item.configureCell(cell)
        return cell
    }
}
