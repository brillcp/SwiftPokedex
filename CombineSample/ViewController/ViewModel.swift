import Foundation

extension ViewController {

    struct ViewModel {
        let title: String
        
        func requestPokemon(_ completion: @escaping (Result<[Pokemon], Error>) -> Swift.Void) {
            do {
                let response = try PokemonAPI.searchPokemons()
                completion(.success(response.results))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
