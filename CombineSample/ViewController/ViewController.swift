import UIKit

final class ViewController: UIViewController {

    private let viewModel = ViewModel(title: "Pokedex")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestPokemon { result in
            switch result {
            case .success(let pokemon):
                print(pokemon)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
