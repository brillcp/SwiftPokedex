import Foundation

struct TableSection {
    var title: String? = nil
    let items: [CellConfigurator]
}

struct TableDataSource {
    var sections = [TableSection]()
}

extension TableDataSource {
    
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
    
    func item(at indexPath: IndexPath) -> CellConfigurator {
        sections[indexPath.section].items[indexPath.row]
    }
}
