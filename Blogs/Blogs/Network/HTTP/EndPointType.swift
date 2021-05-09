//
//  EndPointType.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

