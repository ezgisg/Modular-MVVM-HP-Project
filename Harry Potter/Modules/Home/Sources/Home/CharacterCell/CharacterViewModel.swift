//
//  File.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 17.07.2024.
//


import AppResources
import Foundation

protocol CharacterViewModelProtocol: AnyObject {
    func load()
}

protocol CharacterViewModelDelegate: AnyObject {
    func setUI(character: CharacterResponse)
}

final class CharacterViewModel {
    
    private let character: CharacterResponse
    var delegate: CharacterViewModelDelegate?
    
    init(character: CharacterResponse) {
        self.character = character
    }

}

extension CharacterViewModel: CharacterViewModelProtocol {
    func load() {
        delegate?.setUI(character: character)
    }
}
