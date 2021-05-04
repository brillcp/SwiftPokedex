import UIKit

protocol CollectionCellConfigurator {
    static var reuseId: String { get }
    func configureCell(_ cell: UICollectionViewCell)
}

final class CollectionCellConfiguration<Cell: ConfigurableCell, Data>: CollectionCellConfigurator where Data == Cell.DataType {
    
    static var reuseId: String { String(describing: Cell.self) }
    
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func configureCell(_ cell: UICollectionViewCell) {
        guard let cell = cell as? Cell else { return }
        cell.configure(with: data)
    }
}
