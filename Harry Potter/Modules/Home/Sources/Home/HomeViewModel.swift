//
//  HomeViewModel.swift
//
//
//  Created by Ezgi Sümer Günaydın on 17.07.2024.
//


import AppResources
import Foundation
import Network

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol: AnyObject {
    var characters: [CharacterResponse] { get set }
    func fetchData()
    func searchWithTextLocal(searchText: String)
}

// MARK: - HomeViewModelDelegate
protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
    func controlEmptyView(isHidden: Bool)
}

// MARK: - HomeViewModel
public class HomeViewModel {
    public init() {}
    
    var initialCharacters : [CharacterResponse] = []
    var characters : [CharacterResponse] = []
    var delegate: HomeViewModelDelegate?
    private var service = HPService()
}

extension HomeViewModel: HomeViewModelProtocol {
    func searchWithTextLocal(searchText: String) {
        guard searchText.count != 0 else {
            characters = initialCharacters
            delegate?.controlEmptyView(isHidden: true)
            delegate?.reloadData()
            return
        }
        characters = initialCharacters.filter {
            ($0.name?.uppercased().contains(searchText.uppercased()) ?? false) ||
            ($0.house?.rawValue.uppercased().contains(searchText.uppercased()) ?? false) ||
            ($0.alternateNames?.first?.uppercased().contains(searchText.uppercased()) ?? false)
        }
        
        let isCharactersEmpty = characters.isEmpty
        delegate?.controlEmptyView(isHidden: !isCharactersEmpty)
        delegate?.reloadData()
        
    }
    
    func fetchData() {
        service.fetchAllCharacters { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                characters = response
                initialCharacters = response
                self.delegate?.reloadData()
            case .failure(let error):
                print("Error fetching characters: \(error)")
            }
        }
    }
    
}
