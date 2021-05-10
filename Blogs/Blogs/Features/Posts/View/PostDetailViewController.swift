//
//  PostDetailViewController.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

class PostDetailViewController: AppViewController {
    
    // MARK: Properties
    
    let viewModel: PostDetailViewModel
    
    
    lazy var commentsTV: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: CommentsTableViewCell.identifier)
        tableView.accessibilityIdentifier = "commentsTV"
        tableView.tableFooterView = UIView()
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = AppColor.lineGray.color.cgColor
        tableView.layer.borderWidth = 1.0
        return tableView
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.bold.customFont, size: AppFonts.Size.header)
        label.textColor = AppColor.textGray.color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.regular.customFont, size: AppFonts.Size.header)
        label.textColor = AppColor.textGray.color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "descriptionLabel"
        return label
    }()
    
    private var dataSource: CommentsTableDataSource?
    
    // MARK: Intitializer
    
    init(viewModel: PostDetailViewModel) {
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
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(commentsTV)
        
        self.titleLabel.text = viewModel.postObject.title
        self.descriptionLabel.text = viewModel.postObject.body
        
        dataSource = CommentsTableDataSource(didSelectItemHandler: didSelectCommentMethod())
        
        commentsTV.dataSource = dataSource
        commentsTV.delegate = dataSource
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:16),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:16),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-16),
            
            commentsTV.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            commentsTV.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            commentsTV.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            commentsTV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
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
        dataSource?.setCommentObjectsData(viewModel.commentObjects)
        self.commentsTV.reloadData()
    }
    
    //MARK: - Handle Selection
    
    private func didSelectCommentMethod() -> CommentsTableDataSource.CommentSelectionHandler {
        return { (cooment) in
            Utils.printLog(cooment.body)
        }
    }

}
