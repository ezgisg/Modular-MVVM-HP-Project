//
//  File.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 18.07.2024.
//

import Foundation

public extension String {
    ///To convert string to url with using link
    var imageUrl: URL? {
        return URL(string: self)
    }
}
