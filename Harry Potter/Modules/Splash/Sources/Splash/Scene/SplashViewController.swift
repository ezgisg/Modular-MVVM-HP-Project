//
//  SplashViewController.swift
//  
//
//  Created by Ezgi Sümer Günaydın on 12.07.2024.
//

import AppResources
import Home
import UIKit

// MARK: - SplashViewController
public class SplashViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = .magicHat
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {  [weak self] in
            guard let self else { return }
            self.navigateToHome()
        }
    }
    
    // MARK: - Module init
    public init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SplashViewController
private extension SplashViewController {
    func navigateToHome() {
        let homeVC = HomeViewController()
        homeVC.viewModel = HomeViewModel()
        navigationController?.setViewControllers([homeVC], animated: true)
    }
}
