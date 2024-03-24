//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 19.03.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - Public Methods
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
//    func fetchCharacters(from url: URL, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data else {
//                print(error?.localizedDescription ?? "No error description")
//                completion(.failure(.noData))
//                return
//            }
//            
//            do {
//                let characters = try JSONDecoder().decode(RickAndMorty.self, from: data)
//                completion(.success(characters))
//                DispatchQueue.main.async {
//                    completion(.success(characters))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }.resume()
//    }
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
