import Foundation
import Combine

struct PlacesAPI {
    private static let agent = NetworkAgent()
    private static let baseURL = URL(string: "")!
    
    static func searchPokemons() -> AnyPublisher<PlacesResponse, Error> {
        let request = URLRequest(url: baseURL)
        return agent.execute(request)
    }
}
