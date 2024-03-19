//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 17.03.24.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterLabel: UILabel!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public Methods
    func configure(with results: Results) {
        characterLabel.text = results.name
        
        networkManager.fetchImage(from: results.image) { [ unowned self ] result in
            switch result {
            case .success(let imageData):
                characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
