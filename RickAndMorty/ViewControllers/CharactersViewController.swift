//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 17.03.24.
//

import UIKit
import Alamofire

final class CharactersViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var charactersTableView: UITableView!
    
    // MARK: - Private Properties
    private var characterResults: [Character] = []
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchCharacters()
    }
    
    // MARK: - Private Methods
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

// MARK: - Networking
extension CharactersViewController {
    
    private func fetchCharacters() {
        AF.request(NetworkManager.APIEndpoint.baseURL.url)
            .validate()
            .responseJSON { [unowned self] dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let allCharacters = value as? [String: Any] else { return }
//                    print(allCharacters)
                    
                    for (key, value) in allCharacters {
                        if key == "info" {
                            guard let value = value as? [String: Any] else { return }
                                let info = Info(
                                pages: value["pages"] as? Int ?? 0,
                                next: value["next"] as? String ?? "",
                                prev: value["prev"] as? String ?? ""
                            )
                            print(info)
                        }
                        
                        if key == "results" {
                            guard let value = value as? [[String: Any]] else { return }

                            for character in value {
                                let results = Character(
                                    id: character["id"] as? Int ?? 0,
                                    name: character["name"] as? String ?? "",
                                    status: character["status"] as? String ?? "",
                                    species: character["species"] as? String ?? "",
                                    type: character["type"] as? String ?? "",
                                    gender: character["gender"] as? String ?? "",
                                    origin: character["origin"] as? Location ?? Location(name: "", url: ""), // Как быть с этими типами?
                                    location: character["location"] as? Location ?? Location(name: "", url: ""),
                                    image: character["image"] as? String ?? "",
                                    episode: character["episode"] as? [String] ?? [],
                                    url: character["url"] as? String ?? "",
                                    created: character["created"] as? String ?? ""
                                )
                                
                                characterResults.append(results)
                                print(characterResults)
                            }
                        }
                    }
                    
                    charactersTableView.reloadData()
                    activityIndicator.stopAnimating()
                    
                case .failure(let error):
                    showAlert(with: "Failed", message: error.localizedDescription)
                }
            }
    }
    
//    private func fetchCharacters() {
//        networkManager.fetchCharacters(from: Link.characters.url) { [ unowned self ] characters in
//            switch characters {
//            case .success(let characters):
//                characterResults = characters.results
//                DispatchQueue.main.async {
//                    self.charactersTableView.reloadData()
//                    self.activityIndicator.stopAnimating()
//                }
//            case .failure(let error):
//                print(error)
//                showAlert(with: "Failed", message: "You can see error in the Debug area")
//            }
//        }
//    }
}

// MARK: - UITableViewDataSource
extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "characterCell",
            for: indexPath
        )
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        let character = characterResults[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        95
    }
    
}
