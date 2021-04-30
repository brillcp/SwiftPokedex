import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    
    var data: DataType? { get }
    func configure(with data: DataType)
}

protocol CellConfigurator {
    static var reuseId: String { get }
    var rowHeight: CGFloat { get }
    func configureCell(_ cell: UITableViewCell)
}

final class CellConfiguration<Cell: ConfigurableCell, Data>: CellConfigurator where Data == Cell.DataType {
    
    static var reuseId: String { String(describing: Cell.self) }
    
    var rowHeight: CGFloat
    let data: Data
    
    init(data: Data, rowHeight: CGFloat = 44.0) {
        self.data = data
        self.rowHeight = rowHeight
    }
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? Cell else { return }
        cell.configure(with: data)
    }
}
