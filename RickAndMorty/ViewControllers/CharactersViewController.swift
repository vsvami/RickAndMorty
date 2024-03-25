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
    @IBOutlet var prevButton: UIBarButtonItem!
    @IBOutlet var nextButton: UIBarButtonItem!
    
    // MARK: - Private Properties
    private var characterResults: [Character] = []
//    private var rickAndMorty: RickAndMorty?
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        setupNavigationBar()
        
        fetchCharacters()
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = charactersTableView.indexPathForSelectedRow else { return }
        let character = characterResults[indexPath.row]
        
        guard let detailsVC = segue.destination as? CharacterDetailsViewController else { return }
        detailsVC.character = character
    }
    
    // MARK: - IB Actions
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        
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
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemGray]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemGray]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
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
//                rickAndMorty = character
                
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
//        rickAndMorty?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "characterCell",
            for: indexPath
        )
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        let character = characterResults[indexPath.row]
//        let character = rickAndMorty?.results[indexPath.row]
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
        100
    }
    
}
