//
//  AppCoordinatorProtocol.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

protocol AppCoordinatorProtocol {
    func start()
}

protocol ShowPostDetailCoordinatorDelegate: AnyObject {
    func showPostDetail(for postObject: PostObject, from viewController: UIViewController)
}
