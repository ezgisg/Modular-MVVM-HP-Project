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
   public let id: String?
   public let name: String?
   public let alternateNames: [String]?
   public let species: String?
   public let gender: Gender?
   public let house: House?
   public let dateOfBirth: String?
   public let yearOfBirth: Int?
   public let wizard: Bool?
   public let ancestry: String?
   public let eyeColour: String?
   public let hairColour: String?
   public let wand: Wand?
   public let patronus: String?
   public let hogwartsStudent: Bool?
   public let hogwartsStaff: Bool?
   public let actor: String?
   public let alternateActors: [String]?
   public let alive: Bool?
   public let image: String?
    
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

