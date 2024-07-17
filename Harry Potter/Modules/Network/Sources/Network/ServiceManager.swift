//
//  ServiceManager.swift
//
//
//  Created by Ezgi Sümer Günaydın on 12.07.2024.
//

import AppResources
import Foundation

// MARK: - HPServiceProtocol
protocol HPServiceProtocol {
    func fetchAllCharacters(completion: @escaping (CharactersResult) -> ())
}

// MARK: - HPService
public class HPService: HPServiceProtocol {
    public init() {}
    public func fetchAllCharacters(completion: @escaping (CharactersResult) -> ()) {
        NetworkManager.shared.request(Router.allCharacters, decodeToType: [CharacterResponse].self, completion: completion)
    }
}
