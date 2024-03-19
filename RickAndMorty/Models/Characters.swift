//
//  Character.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 17.03.24.
//

import Foundation

struct Location: Decodable {
    let name: String
    let url: String
}

struct Results: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: URL
    let episode: [URL]
    let url: URL
    let created: String
}

struct Characters: Decodable {
    let results: [Results]
}
