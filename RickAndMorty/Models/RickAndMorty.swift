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

struct Character: Decodable {
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

struct Info: Decodable {
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Episode: Decodable {
    let name: String
    let date: String
    let episode: String
    let characters: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, episode, characters
        case date = "air_date"
    }
}
