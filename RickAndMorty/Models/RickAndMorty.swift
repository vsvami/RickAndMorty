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
    
//    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, image: String, episode: [String], url: String, created: String) {
//        self.id = id
//        self.name = name
//        self.status = status
//        self.species = species
//        self.type = type
//        self.gender = gender
//        self.origin = origin
//        self.location = location
//        self.image = image
//        self.episode = episode
//        self.url = url
//        self.created = created
//    }
    
    init(character: [String: Any]) {
        id = character["id"] as? Int ?? 0
        name = character["name"] as? String ?? ""
        status = character["status"] as? String ?? ""
        species = character["species"] as? String ?? ""
        type = character["type"] as? String ?? ""
        gender = character["gender"] as? String ?? ""
        origin = character["origin"] as? Location ?? Location(name: "", url: "") // Как быть с этими типами?
        location = character["location"] as? Location ?? Location(name: "", url: "")
        image = character["image"] as? String ?? ""
        episode = character["episode"] as? [String] ?? []
        url = character["url"] as? String ?? ""
        created = character["created"] as? String ?? ""
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let value = value as? [[String: Any]] else { return [] }
        
        return value.map { Character(character: $0) }
//        var characterResults: [Character] = []
//        
//        for character in value {
//            let results = Character(character: character)
//            characterResults.append(results)
//        }
//        
//        return characterResults
    }
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
    
    init(pages: Int, next: String?, prev: String?) {
        self.pages = pages
        self.next = next
        self.prev = prev
    }
    
    init(value: [String: Any]) {
        pages = value["pages"] as? Int ?? 0
        next = value["next"] as? String ?? ""
        prev = value["prev"] as? String ?? ""
    }
    
    static func getInfo(from value: Any) -> Info {
        guard let value = value as? [String: Any] else {
            return Info(pages: 0, next: "", prev: "")
        }
        let info = Info(value: value)
        return info
    }
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
