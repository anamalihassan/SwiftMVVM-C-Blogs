//
//  PostsAPIService.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation

protocol PostsAPIService {
    typealias BlogPostsCompletionHandler = ([PostObject]?, String?) -> Void
    
    func getBlogPosts(completion: @escaping BlogPostsCompletionHandler)
    
}

struct PostsAPIServiceImpl:PostsAPIService {
    static let environment : NetworkEnvironment = .production
    let router = Router<BlogsAPI>()
    
    func getBlogPosts(completion: @escaping PostsAPIService.BlogPostsCompletionHandler) {
        
        router.request(.posts) { data, response, error in
            
            if error != nil {
                completion(nil, NetworkResponse.networkConnectionError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Array<PostObject>.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case networkConnectionError = "Please check your network connection."
}

enum Result<String>{
    case success
    case failure(String)
}
