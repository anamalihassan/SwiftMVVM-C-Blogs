//
//  BlogsEndPointType.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum BlogsAPI {
    case posts
    case comments(postId: Int)
}

extension BlogsAPI: EndPointType {
    
    var environmentBaseURL : String {
        switch PostsAPIServiceImpl.environment {
        case .production: return "http://jsonplaceholder.typicode.com/"
        case .qa: return "http://jsonplaceholder.typicode.com/"
        case .staging: return "http://jsonplaceholder.typicode.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
        case let .comments(postId):
            return "posts/\(postId)/comments"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


