//
//  HomeViewController.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 17.07.2024.
//

import AppResources
import Base
import Detail
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
    private let emptyView = EmptyView()
    
    // MARK: - Module Components
    public var viewModel = HomeViewModel()
    
    // MARK: - Life Cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchData()
        configureCollectionView()
        searchBar.delegate = self
        configureEmptyView()
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
    
    func controlEmptyView(isHidden: Bool) {
        collectionView.isHidden = !isHidden
        emptyView.isHidden = isHidden
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
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionType = HomeScreenSectionType(rawValue: indexPath.section) else { return nil }
            switch sectionType {
            case .characters:
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier,
                    for: indexPath
                ) as? HeaderCollectionReusableView
                header?.configure(with: "⚡️Characters⚡️")
                return header
            }
        }
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(196))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),  heightDimension: .estimated(196))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
    
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                     layoutSize: headerSize,
                     elementKind: UICollectionView.elementKindSectionHeader,
                     alignment: .top
                 )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
}

// MARK: - Configures
private extension HomeViewController {
    final func configureCollectionView() {
        collectionView.delegate = self
        configureDataSource()
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.register(cellType: CharacterCollectionViewCell.self, bundle: Bundle.module)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier)
    }
    
    private func configureEmptyView() {
         view.addSubview(emptyView)
         emptyView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             emptyView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
             emptyView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
             emptyView.topAnchor.constraint(equalTo: collectionView.topAnchor),
             emptyView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
         ])
         emptyView.isHidden = true
         emptyView.configure(with: "No Result")
     }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchWithTextLocal(searchText: searchText)
    }
}

// MARK: - HeaderCollectionReusableView
class HeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "HeaderCollectionReusableView"
    
    // MARK: - Private Variables
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(label)
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    func configure(with title: String) {
        label.text = title
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.viewModel = DetailViewModel(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
