//
//  Router.swift
//
//
//  Created by Ezgi Sümer Günaydın on 12.07.2024.
//

import Foundation
import Alamofire

// MARK: - Router
enum Router: URLRequestConvertible {
    static let apiKey = ""
    
    case allCharacters
    
    var baseURL: URL? {
        return URL(string: "https://hp-api.herokuapp.com/api/")
    }
    
    var path: String {
        switch self {
        case .allCharacters:
            return "characters"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allCharacters:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        default:
            return URLEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let baseURL else { throw URLError(.badURL) }
        var urlRequest = URLRequest(url: baseURL.appending(path: path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let request = try encoding.encode(urlRequest, with: nil)
            debugPrint("*** Request URL: ", request.url ?? "")
            return request
        } catch  {
            debugPrint("*** Error urlrequest: ", error)
            throw error
        }
    }
}
