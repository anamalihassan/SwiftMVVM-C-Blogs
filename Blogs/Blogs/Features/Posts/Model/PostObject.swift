//
//  PostObject.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation

class PostObject: NSObject, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
}
