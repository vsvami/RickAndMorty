//
//  Character.swift
//  RickAndMorty
//
//  Created by Vladimir Dmitriev on 17.03.24.
//

import Foundation

struct Location {
    let name: String
    let url: String
    
    init(locationDetails: [String: String]) {
        name = locationDetails["name"] ?? ""
        url = locationDetails["url"] ?? ""
    }
}

struct Episode {
    let name: String
    let date: String
    let episode: String
    let characters: [String]
    
//    enum CodingKeys: String, CodingKey {
//        case name, episode, characters
//        case date = "air_date"
//    }
}

struct Character {
//    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
//    let url: String
//    let created: String

    init(characterDetails: [String: Any]) {
//        id = characterDetails["id"] as? Int ?? 0
        name = characterDetails["name"] as? String ?? ""
        status = characterDetails["status"] as? String ?? ""
        species = characterDetails["species"] as? String ?? ""
        type = characterDetails["type"] as? String ?? ""
        gender = characterDetails["gender"] as? String ?? ""
        
        let originDetails = characterDetails["origin"] as? [String: String] ?? [:]
        origin = Location(locationDetails: originDetails)
        
        let locationDetails = characterDetails["location"] as? [String: String] ?? [:]
        location = Location(locationDetails: locationDetails)
        
        image = characterDetails["image"] as? String ?? ""
        
        episode = characterDetails["episode"] as? [String] ?? []
//        url = characterDetails["url"] as? String ?? ""
//        created = characterDetails["created"] as? String ?? ""
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let results = value as? [[String: Any]] else { return [] }
        return results.map { Character(characterDetails: $0) }
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

struct Info {
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
        return Info(value: value)
    }
}

struct RickAndMorty {
    let info: Info
    let results: [Character]
    
    init(characters: [String: Any]) {
        let infoDetails = characters["info"] as? [String: Any] ?? [:]
        info = Info.getInfo(from: infoDetails)
        
        let charactersDetails = characters["results"] as? [[String: Any]] ?? [[:]]
        results = Character.getCharacters(from: charactersDetails)
    }
}
