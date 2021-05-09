//
//  PostsViewModel.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation

class PostsViewModel {
    
    // MARK: - Properties
    
    var postObjects: [PostObject] = [] {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    var error: String? {
        didSet { self.showAlert?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private let apiService: PostsAPIService
    
    var showAlert: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init( apiService: PostsAPIService = PostsAPIServiceImpl()) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func getBlogPosts() {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.apiService.getBlogPosts(completion: { (response, error) in
            self.isLoading = false
            if let errorMessage = error{
                self.error = errorMessage
            }else {
                self.postObjects = response ?? []
            }
        })
    }
}
