//
//  HomeViewController.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 17.07.2024.
//

import AppResources
import Base
import UIKit
import Components

// MARK: - Enums
enum HomeScreenSectionType: Int, CaseIterable {
    case characters = 0
}

// MARK: - HomeViewController
public class HomeViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Private Variables
    private var dataSource: UICollectionViewDiffableDataSource<HomeScreenSectionType, CharacterResponse>?
    
    // MARK: - Module Components
    public var viewModel = HomeViewModel()
    
    // MARK: - Life Cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchData()
        configureCollectionView()
    }

    
    // MARK: - Module init
    public init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        applySnapshot()
    }
    
}

// MARK: - Diffable Data Source
private extension HomeViewController {
    final func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, character in
            guard let sectionType = HomeScreenSectionType(rawValue: indexPath.section) else { return UICollectionViewCell() }
            switch sectionType {
            case .characters:
                let cell = collectionView.dequeueReusableCell(with: CharacterCollectionViewCell.self, for: indexPath)
    
                cell.viewModel = CharacterViewModel(character: character)
                return cell
            }
        })
    }
    
    final func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<HomeScreenSectionType, CharacterResponse>()
        for section in HomeScreenSectionType.allCases {
            snapshot.appendSections([section])
        }
        let characters = viewModel.characters
        snapshot.appendItems(characters, toSection: .characters)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Compositional Layout
private extension HomeViewController {
    final func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self,
                  let sectionType = HomeScreenSectionType(rawValue: sectionIndex) else { return nil }
            switch sectionType {
            case .characters:
                return createCharactersSection()
            }
        }
    }
    
    final func createCharactersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),  heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
}

private extension HomeViewController {
    final func configureCollectionView() {
        configureDataSource()
        collectionView.register(cellType: CharacterCollectionViewCell.self, bundle: Bundle.module)
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
}
