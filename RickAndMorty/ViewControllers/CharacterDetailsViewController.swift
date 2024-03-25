//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 25.03.24.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var characterLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var firstEpisodeLabel: UILabel!
    
    // MARK: - Public properties
    var character: Character!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
        
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = character.name
        
        characterLabel.text = character.name
        statusLabel.text = character.status
        speciesLabel.text = character.species
        genderLabel.text = character.gender
        originLabel.text = character.location.name
        locationLabel.text = character.location.name
        
        fetchImage()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodesVC = segue.destination as? EpisodesViewController else { return }
        episodesVC.character = character
    }
    
    // MARK: - Private Methods
    
    private func fetchImage() {
        networkManager.fetchData(from: character.image) { [unowned self] result in
            switch result {
            case .success(let imageData):
                characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

