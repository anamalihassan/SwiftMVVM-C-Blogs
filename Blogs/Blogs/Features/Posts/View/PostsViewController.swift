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
    
    weak var delegate: ShowPostDetailCoordinatorDelegate?
    
    lazy var postsTV: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.identifier)
        tableView.accessibilityIdentifier = "postsTV"
        tableView.tableFooterView = UIView()
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = AppColor.lineGray.color.cgColor
        tableView.layer.borderWidth = 1.0
        return tableView
    }()
    
    private var dataSource: PostsTableDataSource?
    
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
        self.view.addSubview(postsTV)
        
        dataSource = PostsTableDataSource(didSelectItemHandler: didSelectPostMethod())
        
        postsTV.dataSource = dataSource
        postsTV.delegate = dataSource
        
        NSLayoutConstraint.activate([
            postsTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postsTV.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            postsTV.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            postsTV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
    }
    
    // MARK: reload Data
    
    func reloadData() {
        dataSource?.setPostObjectsData(viewModel.postObjects)
        self.postsTV.reloadData()
    }
    
    //MARK: - Handle Selection
    
    private func didSelectPostMethod() -> PostsTableDataSource.PostSelectionHandler {
        return { [weak self] (postObject) in
            if let strongSelf = self {
                strongSelf.delegate?.showPostDetail(for: postObject, from: strongSelf)
            }
        }
    }

}
