//
//  PostsViewController.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

class PostsViewController: AppViewController {
    
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
        setUpViewModel()
    }
    
    // MARK: set up view
    
    func setUpView(){
        self.view.backgroundColor = AppColor.appSecondary.color
        self.navigationItem.title = Constants.App.POSTS_MSG
    }
    
    // MARK: set up view model
    
    private func setUpViewModel() {
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlert = {
            if let error = self.viewModel.error {
                Utils.printLog(error)
                let title = Constants.APIMessages.Warning
                let action = UIAlertAction(title: Constants.APIMessages.OK, style: .default)
                DispatchQueue.main.async {
                    Utils.displayAlert(forViewController: self, with: title , message: error, actions: [action])
                }
            }
        }
        
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
        
        self.getBlogPosts()
    }
    
    // MARK: reload Data
    
    func reloadData() {
        Utils.printLog(viewModel.postObjects.count)
    }
    
    // MARK: - Call API
    
    private func getBlogPosts()  {
        viewModel.getBlogPosts()
    }

}
