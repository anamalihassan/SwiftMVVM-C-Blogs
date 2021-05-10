//
//  PostDetailViewModel.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation

class PostDetailViewModel {
    
    // MARK: - Properties
    
    var commentObjects: [CommentObject] = [] {
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
    
    let postObject: PostObject
    
    var showAlert: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(postObject: PostObject, apiService: PostsAPIService = PostsAPIServiceImpl()) {
        self.postObject = postObject
        self.apiService = apiService
        getBlogPostComments(postId: self.postObject.id)
    }
    
    // MARK: - Network call
    
    func getBlogPostComments(postId: Int) {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.apiService.getBlogPostComments(postId: postId, completion: { (response, error) in
            self.isLoading = false
            if let errorMessage = error{
                self.error = errorMessage
            }else {
                self.commentObjects = response ?? []
            }
        })
    }
}
