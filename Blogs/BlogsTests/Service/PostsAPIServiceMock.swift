//
//  PostsAPIServiceMock.swift
//  BlogsTests
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation

@testable import Blogs

class PostsAPIServiceMock: PostsAPIService {
    
    func getBlogPostComments(postId: Int, completion: @escaping ([CommentObject]?, String?) -> Void) {
        isGetBlogPostCommentsCalled = true
        let comments = StubGenerator().stubBlogPostComments()
        completion(comments, nil)
    }
    
    func getBlogPosts(completion: @escaping BlogPostsCompletionHandler) {
        isGetBlogPostsCalled = true
        let posts = StubGenerator().stubBlogPosts()
        completion(posts, nil)
    }
    
    var isGetBlogPostsCalled = false
    
    var isGetBlogPostCommentsCalled = false
    
}

class StubGenerator {
    func stubBlogPosts() -> [PostObject] {
        let path = Bundle(for: type(of: self)).path(forResource: "Posts", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try! decoder.decode(Array<PostObject>.self, from: data)
        return result
    }
    
    func stubBlogPostComments() -> [CommentObject] {
        let path = Bundle(for: type(of: self)).path(forResource: "Comments", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try! decoder.decode(Array<CommentObject>.self, from: data)
        return result
    }
}

