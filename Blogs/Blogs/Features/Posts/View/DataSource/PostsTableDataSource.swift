//
//  PostsTableDataSource.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

class PostsTableDataSource: NSObject {
    typealias PostSelectionHandler = (PostObject) -> ()
    
    private var postObjects: [PostObject] = []
    private var didSelectItemHandler: PostSelectionHandler?
    
    init(with postObjects: [PostObject] = [], didSelectItemHandler: @escaping PostSelectionHandler) {
        self.postObjects = postObjects
        self.didSelectItemHandler = didSelectItemHandler
    }
    
    func setPostObjectsData(_ postObjects: [PostObject]) {
        self.postObjects = postObjects
    }
}

// MARK: - Table View Data Source

extension PostsTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as! PostsTableViewCell
        cell.accessibilityIdentifier = "postsTableViewCell_\(indexPath.row)"
        cell.configureCell(data: postObjects[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Table View Delegate

extension PostsTableDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postObject = postObjects[indexPath.row]
        didSelectItemHandler?(postObject)
    }
}
