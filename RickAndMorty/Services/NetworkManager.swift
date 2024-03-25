//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 19.03.24.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - Public Methods
    func fetchCharacters(
        from url: URL,
        completion: @escaping(Result<RickAndMorty, AFError>) -> Void
    ) {
        AF.request(NetworkManager.APIEndpoint.baseURL.url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let allCharacters = value as? [String: Any] else { return }
                    let rickAndMorty = RickAndMorty(characters: allCharacters)
                    completion(.success(rickAndMorty))
                case .failure(let error):
                    print(error)
                    completion(.failure(error ))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
}

// MARK: - APIEndpoint
extension NetworkManager {
    enum APIEndpoint {
        case baseURL
        
        var url: URL {
            switch self {
            case .baseURL:
                URL(string: "https://rickandmortyapi.com/api/character")!
            }
        }
    }
}
