//
//  File.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 18.07.2024.
//

import Foundation
import UIKit.UIImageView
import Kingfisher

///To load image from url with KF
public extension UIImageView {
    func loadImage(with URL: URL, cornerRadius: CGFloat = 10, placeholderImage: UIImage? = nil) {
        kf.indicatorType = .activity
        contentMode = .scaleToFill
        layer.cornerRadius = cornerRadius
        kf.setImage(with: URL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                image = data.image
            case .failure(let error):
                debugPrint("Görüntü yüklenirken hata oluştu: \(error.localizedDescription)")
                if let placeholderImage {
                    image = placeholderImage
                }
            }
        }
    }
}

