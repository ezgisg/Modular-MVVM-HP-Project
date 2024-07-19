//
//  DetailViewModel.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 19.07.2024.
//

import AppResources
import Foundation

// MARK: - DetailViewModelProtocol
protocol DetailViewModelProtocol: AnyObject {
    var character: CharacterResponse { get }
}

// MARK: - DetailViewModelDelegate
protocol DetailViewModelDelegate: AnyObject {
    
}

// MARK: - DetailViewModel
public class DetailViewModel {
    var character: CharacterResponse
    
    public init(character: CharacterResponse) {
        self.character = character
    }
    
}
