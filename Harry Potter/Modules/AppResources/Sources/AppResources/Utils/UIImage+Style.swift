//
//  UIImage+Style.swift
//
//
//  Created by Ezgi Sümer Günaydın on 17.07.2024.
//

import Foundation
import UIKit.UIImage

public extension UIImage {
    static var magicHat: UIImage? {
        return UIImage(named: "magicHat", in: Bundle.module, compatibleWith: .current)
    }
}
