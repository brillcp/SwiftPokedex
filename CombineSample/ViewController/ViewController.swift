import UIKit

final class ViewController: TableViewController<PokemonCell> {

    private let viewModel = ViewModel(title: "Pokedex")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestPokemon(type: .ground) { result in
            switch result {
            case .success(let pokemon):
                self.tableData = pokemon
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
