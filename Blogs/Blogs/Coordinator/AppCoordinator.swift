//
//  AppCoordinator.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

class AppCoordinator: AppCoordinatorProtocol {
    
    var rootViewController: UINavigationController!
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let window = window else { return }
        
        rootViewController = UINavigationController(rootViewController: getPaymentMethodsViewController())
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func getPaymentMethodsViewController() -> PostsViewController {
        let viewModel = PostsViewModel()
        let viewController = PostsViewController(viewModel: viewModel)
//        viewController.delegate = self
        return viewController
    }
}
