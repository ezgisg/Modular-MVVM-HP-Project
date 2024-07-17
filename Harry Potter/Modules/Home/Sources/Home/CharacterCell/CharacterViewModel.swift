//
//  File.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 17.07.2024.
//


import AppResources
import Foundation

protocol CharacterViewModelProtocol: AnyObject {
    
}

protocol CharacterViewModelDelegate: AnyObject {
    
}

final class CharacterViewModel {
    private let character: CharacterResponse
    
    init(character: CharacterResponse) {
        self.character = character
    }

}
