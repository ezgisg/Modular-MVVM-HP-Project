//
//  CharacterCollectionViewCell.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 17.07.2024.
//

import AppResources
import UIKit
import Components

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterOtherName: UILabel!
    @IBOutlet weak var characterHouse: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var houseImage: UIImageView!
    
    var viewModel: CharacterViewModel? {
        didSet {
            viewModel?.delegate = self
            viewModel?.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        houseImage.image = .magicHat
        // Initialization code
    }
    
}

extension CharacterCollectionViewCell: CharacterViewModelDelegate {
    func setUI(character: CharacterResponse) {

        characterName.text = character.name
        
        if let image = character.image?.imageUrl {
            characterImage.loadImage(with: image, cornerRadius: 10)
        } else if let gender = character.gender {
            switch gender {
            case .male:
                characterImage.image = .man
            case .female:
                characterImage.image = .woman
            case .unknown:
                characterImage.image = .wand
            }
        } else {
            characterImage.image = .magicHat
        }

        characterOtherName.text = character.alternateNames?.first.valueOrDefault

        if let house = character.house {
            characterHouse.text = house.rawValue
            switch house {
            case .Gryffindor:
                houseImage.image = .gryffindor
            case .Slytherin:
                houseImage.image = .slytherin
            case .Hufflepuff:
                houseImage.image = .hufflepuff
            case .Ravenclaw:
                houseImage.image = .ravenclaw
            case .unknown:
                houseImage.image = .magicHat
                
                if let species = character.species,
                   species != "human" {
                    characterHouse.text = species.capitalized
                } else {
                    characterHouse.text = "There is no information for this character"
                }
            }
        }
        
    }
    
}
