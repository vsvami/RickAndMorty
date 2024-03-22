//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 17.03.24.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet var characterLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView! {
        didSet {
//            characterImageView.contentMode = .scaleAspectFit
//            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = 15
        }
    }
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public Methods
    func configure(with results: Results) {
        characterLabel.text = results.name
        
        networkManager.fetchImage(from: results.image) { [ unowned self ] result in
            switch result {
            case .success(let imageData):
                characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
