//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 17.03.24.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    private var characterResults: [Results] = []
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchCharacters()
    }
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detailsVC = segue.destination as? DetailsViewController
//    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        characterResults.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "characterDetails",
            for: indexPath
        )
        guard let cell = cell as? CharacterCell else { return UICollectionViewCell() }
        let character = characterResults[indexPath.item]
        cell.configure(with: character)
        
        return cell
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

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: (view.window?.windowScene?.screen.bounds.width ?? 100) / 2 - 30,
            height: 200
        )
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchCharacters() {
        networkManager.fetchCharacters(from: Link.characters.url) { [ unowned self ] characters in
            switch characters {
            case .success(let characters):
                characterResults = characters.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.showAlert(with: "Success", message: "You can see the results in the Debug area")
                }
            case .failure(let error):
                print(error)
                showAlert(with: "Failed", message: "You can see error in the Debug area")
            }
        }
    }
}
