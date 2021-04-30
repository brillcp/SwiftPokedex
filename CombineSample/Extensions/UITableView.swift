import UIKit

extension UITableView {
    func cell<Cell: UITableViewCell>(at indexPath: IndexPath) -> Cell? {
        cellForRow(at: indexPath) as? Cell
    }
    
    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: reuseIdentifier(for: cell))
    }

    func dequeueCell<Cell: UITableViewCell>(for item: CellConfigurator) -> Cell {
        dequeueReusableCell(withIdentifier: type(of: item).reuseId) as! Cell
    }

    private func reuseIdentifier<Cell: UITableViewCell>(for cell: Cell.Type) -> String {
        String(describing: cell)
    }
}
