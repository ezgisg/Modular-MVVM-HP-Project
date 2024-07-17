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
}

// MARK: - HomeViewModelDelegate
protocol HomeViewModelDelegate: AnyObject {
//    func getData(data: [CharacterResponse])
    func reloadData()
}

// MARK: - HomeViewModel
public class HomeViewModel {
    public init() {}
    
    var characters : [CharacterResponse] = []
    var delegate: HomeViewModelDelegate?
    private var service = HPService()
}

extension HomeViewModel: HomeViewModelProtocol {
    func fetchData() {
        service.fetchAllCharacters { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                characters = response
//                self.delegate?.getData(data: response)
                self.delegate?.reloadData()
            case .failure(let error):
                print("Error fetching characters: \(error)")
            }
        }
    }
    
}
