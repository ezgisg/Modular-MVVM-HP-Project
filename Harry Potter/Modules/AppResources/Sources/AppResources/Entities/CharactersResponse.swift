//
//  CharacterResponse.swift
//
//
//  Created by Ezgi Sümer Günaydın on 12.07.2024.
//

import Foundation

// MARK: - Enums
// MARK: - Gender
public enum Gender: String, Decodable {
    case male
    case female
    case unknown = ""
}

// MARK: - House
public enum House: String, Decodable {
    case Gryffindor
    case Slytherin
    case Hufflepuff
    case Ravenclaw
    case Unknown = ""
}

// MARK: - CharacterResponse
public struct CharacterResponse: Decodable, Hashable {
    let id: String?
    let name: String?
    let alternateNames: [String]?
    let species: String?
    let gender: Gender?
    let house: House?
    let dateOfBirth: String?
    let yearOfBirth: Int?
    let wizard: Bool?
    let ancestry: String?
    let eyeColour: String?
    let hairColour: String?
    let wand: Wand?
    let patronus: String?
    let hogwartsStudent: Bool?
    let hogwartsStaff: Bool?
    let actor: String?
    let alternateActors: [String]?
    let alive: Bool?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case alternateNames = "alternate_names"
        case species
        case gender
        case house
        case dateOfBirth
        case yearOfBirth
        case wizard
        case ancestry
        case eyeColour
        case hairColour
        case wand
        case patronus
        case hogwartsStudent
        case hogwartsStaff
        case actor
        case alternateActors = "alternate_actors"
        case alive
        case image
    }
    
    public static func == (lhs: CharacterResponse, rhs: CharacterResponse) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Wand
public struct Wand: Decodable {
    let wood: String?
    let core: String?
    let length: Double?
}

// MARK: - Typealias
public typealias CharactersResult = Result<[CharacterResponse], Error>

