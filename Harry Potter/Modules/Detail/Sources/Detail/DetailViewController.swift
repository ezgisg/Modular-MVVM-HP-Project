//
//  DetailViewController.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 19.07.2024.
//

import AppResources
import Base
import Components
import UIKit

// MARK: - DetailViewController
public class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var info1: UILabel!
    @IBOutlet weak var info2: UILabel!
    @IBOutlet weak var info3: UILabel!
    @IBOutlet weak var info4: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - Module Components
    public var viewModel: DetailViewModel?
    
    // MARK: - Life Cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.flashScrollIndicators()
    }

    // MARK: - Module init
    public init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Initial setups
extension DetailViewController {
    private func setup() {
        guard let character = viewModel?.character else { return }
        setupImage(character: character)
        setupLabels(character: character)
    }
    
    private func setupImage(character: CharacterResponse) {
        if let image = character.image?.imageUrl {
            imageView.loadImage(with: image, cornerRadius: 20)
        } else {
            imageView.isHidden = true
        }
    }
    
    private func setupLabels(character: CharacterResponse) {
        headerLabel.text = character.name?.uppercased()
        
        let alternateNamesTitle = "Alternate Names: "
        var allAlternateNames = "-"
        if let alternateNames = character.alternateNames,
           !alternateNames.isEmpty {
            allAlternateNames = alternateNames.joined(separator: ", ")
        }
        makeBoldPartiallyAndAssign(wholeText: alternateNamesTitle + allAlternateNames, boldPart: alternateNamesTitle, targetLabel: info1)
        
        let ancestry = character.ancestry.value(or: "-")
        let ancestryTitle = "Ancestry: "
        makeBoldPartiallyAndAssign(wholeText: ancestryTitle + ancestry , boldPart: ancestryTitle, targetLabel: info2)
        
        let species = character.species.value(or: "-")
        let speciesTitle = "Species: "
        makeBoldPartiallyAndAssign(wholeText: speciesTitle + species , boldPart: speciesTitle, targetLabel: info3)

        let patronus = character.patronus.value(or: "-")
        let patronusTitle = "Patronus: "
        makeBoldPartiallyAndAssign(wholeText: patronusTitle + patronus , boldPart: patronusTitle, targetLabel: info4)
    }
}

// MARK: - Helpers
extension DetailViewController {
    ///To make bold some part of text
    private func makeBoldPartiallyAndAssign(wholeText: String, boldPart: String, targetLabel: UILabel) {
        let baseString = wholeText
        let attributedString = NSMutableAttributedString(string: baseString)
        let boldFont = UIFont.boldSystemFont(ofSize: targetLabel.font.pointSize)
        let range = (baseString as NSString).range(of: boldPart)
        attributedString.addAttribute(.font, value: boldFont, range: range)
        targetLabel.attributedText = attributedString
    }
}
