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
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
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
