//
//  NetworkManager.swift
//
//
//  Created by Ezgi Sümer Günaydın on 12.07.2024.
//

import Foundation
import Alamofire

// MARK: - NetworkManager
final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func request<T: Decodable> (_ request: URLRequestConvertible, decodeToType type: T.Type, completion: @escaping (Result<T,Error>) -> ()) {
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(type.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                    debugPrint(error.localizedDescription)
                }
            case .failure(let error):
                completion(.failure(error))
                debugPrint(error.localizedDescription)
            }
        }
    }
}
