//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 17.03.24.
//

import UIKit

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
        networkManager.fetchCharacters(
            from: NetworkManager.APIEndpoint.baseURL.url
        ) { [unowned self] result in
            switch result {
            case .success(let character):
                characterResults = character.results
                
                charactersTableView.reloadData()
                activityIndicator.stopAnimating()
            case .failure(let error):
                showAlert(with: "Failure", message: error.localizedDescription)
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
