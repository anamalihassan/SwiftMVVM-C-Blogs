//
//  CommentsTableDataSource.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

class CommentsTableDataSource: NSObject {
    typealias CommentSelectionHandler = (CommentObject) -> ()
    
    private var commentObjects: [CommentObject] = []
    private var didSelectItemHandler: CommentSelectionHandler?
    
    init(with commentObjects: [CommentObject] = [], didSelectItemHandler: @escaping CommentSelectionHandler) {
        self.commentObjects = commentObjects
        self.didSelectItemHandler = didSelectItemHandler
    }
    
    func setCommentObjectsData(_ commentObjects: [CommentObject]) {
        self.commentObjects = commentObjects
    }
}

// MARK: - Table View Data Source

extension CommentsTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CommentsTableViewHeader(frame: .zero)
        headerView.titleLabel.text = Constants.App.COMMENTS_MSG
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.identifier, for: indexPath) as! CommentsTableViewCell
        cell.accessibilityIdentifier = "commentsTableViewCell_\(indexPath.row)"
        cell.configureCell(data: commentObjects[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Table View Delegate

extension CommentsTableDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentObject = commentObjects[indexPath.row]
        didSelectItemHandler?(commentObject)
    }
}
