//
//  PostDetailViewControllerTests.swift
//  BlogsTests
//
//  Created by Ali Hassan on 10/05/2021.
//

import XCTest
@testable import Blogs

class PostDetailViewControllerTests: XCTestCase {
    
    
    let commentObjects = StubGenerator().stubBlogPostComments()
    
    func test_viewDidLoad_rendersHeaderTitle() {
        XCTAssertEqual(makeSUT().navigationItem.title, Constants.App.POSTS_MSG)
    }
    
    func test_viewDidLoad_configuresCommentsTV() {
        XCTAssertNotNil(makeSUT().commentsTV)
    }
    
    func test_post_content() {
        let sut = makeSUT()
        XCTAssertEqual(sut.titleLabel.text, sut.viewModel.postObject.title)
        XCTAssertEqual(sut.descriptionLabel.text, sut.viewModel.postObject.body)
    }
    
    func test_commentsTV_rendersWithoutComments() {
        let sut = makeSUT()
        XCTAssertEqual(sut.commentsTV.numberOfRows(inSection: 0), sut.viewModel.commentObjects.count)
    }
    
    func test_commentsTV_rendersBlogPostComments() {
        XCTAssertEqual(makeSUT().commentsTV.numberOfItems(), commentObjects.count)
    }
    
    func test_commentsTV_rendersCellForCommenttsTV() {
        XCTAssertEqual(makeSUT().commentsTV.title(at: 0), commentObjects[0].name)
        XCTAssertEqual(makeSUT().commentsTV.bodyDescription(at: 0), commentObjects[0].body)
        XCTAssertEqual(makeSUT().commentsTV.title(at: 1), commentObjects[1].name)
        XCTAssertEqual(makeSUT().commentsTV.bodyDescription(at: 1), commentObjects[1].body)
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> PostDetailViewController {
        let postObject = StubGenerator().stubBlogPosts()[0]
        let apiService = PostsAPIServiceMock()
        let viewModel = PostDetailViewModel(postObject: postObject, apiService: apiService)
        
        let sut = PostDetailViewController(viewModel: viewModel)
        _ = sut.view
        sut.reloadData()
        return sut
    }
}

private extension UITableView {
    func numberOfItems() -> Int {
        return numberOfRows(inSection: 0)
    }
    
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(item: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        let commentsTableViewCell = cell(at: row) as! CommentsTableViewCell
        return commentsTableViewCell.titleLabel.text
    }
    
    func bodyDescription(at row: Int) -> String? {
        let commentsTableViewCell = cell(at: row) as! CommentsTableViewCell
        return commentsTableViewCell.descriptionLabel.text
    }
}
