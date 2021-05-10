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
        
        rootViewController = UINavigationController(rootViewController: getPostsViewController())
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func getPostsViewController() -> PostsViewController {
        let viewModel = PostsViewModel()
        let viewController = PostsViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
}

// MARK: - Show Post Detail

extension AppCoordinator: ShowPostDetailCoordinatorDelegate {
    
    func showPostDetail(for postObject: PostObject, from viewController: UIViewController) {
        let postDetailViewController = PostDetailViewController(viewModel: PostDetailViewModel(postObject: postObject))
        viewController.show(postDetailViewController, sender: nil)
    }
}
