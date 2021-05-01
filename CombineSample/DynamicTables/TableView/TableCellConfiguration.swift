import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    
    var data: DataType? { get }
    func configure(with data: DataType)
}

protocol TableCellConfigurator {
    static var reuseId: String { get }
    var rowHeight: CGFloat { get }
    func configureCell(_ cell: UITableViewCell)
}

final class TableCellConfiguration<Cell: ConfigurableCell, Data>: TableCellConfigurator where Data == Cell.DataType {
    
    static var reuseId: String { String(describing: Cell.self) }
    
    var rowHeight: CGFloat
    let data: Data
    
    init(data: Data, rowHeight: CGFloat = 60.0) {
        self.data = data
        self.rowHeight = rowHeight
    }
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? Cell else { return }
        cell.configure(with: data)
    }
}

typealias DetailCellConfig = TableCellConfiguration<DetailCell, DetailItem>

extension TableCellConfiguration {
        
    static func weightCell(value: Int) -> DetailCellConfig {
        DetailCellConfig(data: DetailItem(title: "Weight", value: value.kilo), rowHeight: 50.0)
    }
    
    static func heightCell(value: Int) -> DetailCellConfig {
        DetailCellConfig(data: DetailItem(title: "Height", value: value.meter), rowHeight: 50.0)
    }

    static func abilitiesCell(values: [Ability]) -> DetailCellConfig {
        let abilities = values.map { $0.ability.name.cleaned }.joined(separator: ", ")
        return DetailCellConfig(data: DetailItem(title: "Abilities", value: abilities), rowHeight: UITableView.automaticDimension)
    }
    
    static func typesCell(values: [Type]) -> DetailCellConfig {
        let types = values.map { $0.type.name.cleaned }.joined(separator: ", ")
        return DetailCellConfig(data: DetailItem(title: "Type", value: types), rowHeight: UITableView.automaticDimension)
    }

    static func movesCell(values: [Move]) -> DetailCellConfig {
        let moves = values.map { $0.move.name.cleaned }.joined(separator: ", ")
        return DetailCellConfig(data: DetailItem(title: "Moves", value: moves), rowHeight: UITableView.automaticDimension)
    }
}
