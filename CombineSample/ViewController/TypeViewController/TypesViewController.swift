import UIKit

final class TypesViewController: TableViewController<UITableViewCell> {
    
    private let viewModel = ViewModel(title: "Pokemon Types")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
