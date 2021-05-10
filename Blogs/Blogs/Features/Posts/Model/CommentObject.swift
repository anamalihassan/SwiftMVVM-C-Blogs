//
//  CommentObject.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import Foundation

class CommentObject: NSObject, Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
}
