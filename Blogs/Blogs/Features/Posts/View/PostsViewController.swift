//
//  PostsViewController.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

class PostsViewController: UIViewController {
    
    // MARK: Properties
    
    let viewModel: PostsViewModel
    
    // MARK: Intitializer
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    // MARK: set up view
    
    func setUpView(){
        self.view.backgroundColor = AppColor.appSecondary.color
        self.navigationItem.title = Constants.App.POSTS_MSG
    }


}
