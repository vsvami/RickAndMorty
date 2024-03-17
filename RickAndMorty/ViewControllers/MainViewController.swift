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
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchCharacters()
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        15
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
    
    private func fetchCharacters() {
        URLSession.shared.dataTask(
            with: URL(string: "https://rickandmortyapi.com/api/character")!) {
                [ unowned self] data, _, error in
                guard let data else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                do {
                    let characters = try JSONDecoder().decode(Character.self, from: data)
                    DispatchQueue.main.async {
                        self.showAlert(
                            with: "Success",
                            message: "You can see the results in the Debug area"
                        )
                        self.activityIndicator.stopAnimating()
                    }
                    print(characters)
                } catch {
                    showAlert(
                        with: "Failed",
                        message: "You can see error in the Debug area"
                    )
                    print(error.localizedDescription)
                }
            }.resume()
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
            height: 230
        )
    }
}
