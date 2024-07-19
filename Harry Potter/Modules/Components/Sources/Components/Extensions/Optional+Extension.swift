//
//  Optional+Extension.swift
//
//
//  Created by Ezgi Sümer Günaydın on 18.07.2024.
//

import Foundation

public extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        guard let self else {
            return true
        }
        return self.isEmpty
    }
    
    var valueOrDefault: String {
        guard let self else {
            return ""
        }
        return self
    }
    
    func value(or default: String) -> String {
        guard let self,
            !self.isEmpty else {
            return `default`
        }
        return self
    }
}

