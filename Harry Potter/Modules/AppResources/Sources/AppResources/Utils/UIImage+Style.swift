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
    static var gryffindor: UIImage? {
        return UIImage(named: "gryffindor", in: Bundle.module, compatibleWith: .current)
    }
    static var hufflepuff: UIImage? {
        return UIImage(named: "hufflepuff", in: Bundle.module, compatibleWith: .current)
    }
    static var ravenclaw: UIImage? {
        return UIImage(named: "ravenclaw", in: Bundle.module, compatibleWith: .current)
    }
    static var slytherin: UIImage? {
        return UIImage(named: "slytherin", in: Bundle.module, compatibleWith: .current)
    }
    static var woman: UIImage? {
        return UIImage(named: "woman", in: Bundle.module, compatibleWith: .current)
    }
    
    static var man: UIImage? {
        return UIImage(named: "man", in: Bundle.module, compatibleWith: .current)
    }
    static var wand: UIImage? {
        return UIImage(named: "wand", in: Bundle.module, compatibleWith: .current)
    }
}
