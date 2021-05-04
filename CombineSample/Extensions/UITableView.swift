import UIKit

extension UITableView {
    struct Section {
        var title: String? = nil
        var items: [TableCellConfigurator] = []
    }

    struct DataSource {
        var sections = [Section]()
    }

    func cell<Cell: UITableViewCell>(at indexPath: IndexPath) -> Cell? {
        cellForRow(at: indexPath) as? Cell
    }
    
    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: reuseIdentifier(for: cell))
    }

    func dequeueCell<Cell: UITableViewCell>(for item: TableCellConfigurator) -> Cell {
        dequeueReusableCell(withIdentifier: type(of: item).reuseId) as! Cell
    }

    private func reuseIdentifier<Cell: UITableViewCell>(for cell: Cell.Type) -> String {
        String(describing: cell)
    }
}

extension UITableView.DataSource {
    
    var hasData: Bool { !sections.isEmpty }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].items.count
    }
    
    func title(in section: Int) -> String? {
        sections[section].title
    }
    
    func item(at indexPath: IndexPath) -> TableCellConfigurator {
        sections[indexPath.section].items[indexPath.row]
    }
}
