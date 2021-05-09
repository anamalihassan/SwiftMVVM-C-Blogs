//
//  PostsAPIServiceMock.swift
//  BlogsTests
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation

@testable import Blogs

class PostsAPIServiceMock: PostsAPIService {
    func getBlogPosts(completion: @escaping BlogPostsCompletionHandler) {
        isGetBlogPostsCalled = true
        let posts = StubGenerator().stubBlogPosts()
        completion(posts, nil)
    }
    
    var isGetBlogPostsCalled = false
    
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
}

