//
//  CharacterCollectionViewCell.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 17.07.2024.
//

import AppResources
import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterOtherName: UILabel!
    @IBOutlet weak var characterHouse: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    var viewModel: CharacterViewModel? {
        didSet {
            viewModel?.delegate = self
            viewModel?.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension CharacterCollectionViewCell: CharacterViewModelDelegate {
    func setUI(character: CharacterResponse) {
        //TODO: Gerçek resim KF ile koyulacak
        characterImage.image = .magicHat
        characterName.text = character.name
       
        characterOtherName.text = character.alternateNames?.first ?? ""
        
        characterHouse.text = character.house?.rawValue ?? ""

    }
}
