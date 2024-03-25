//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 25.03.24.
//

import UIKit

final class EpisodesViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var episodesTableView: UITableView!
    
    // MARK: - Public properties
    var character: Character!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    // MARK: - Private Methods
    
}
