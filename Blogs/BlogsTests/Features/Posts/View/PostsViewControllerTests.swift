//
//  PostsViewControllerTests.swift
//  BlogsTests
//
//  Created by Ali Hassan on 10/05/2021.
//

import XCTest
@testable import Blogs

class PostsViewControllerTests: XCTestCase {
    
    
    let postObjects = StubGenerator().stubBlogPosts()
    
    func test_viewDidLoad_rendersHeaderTitle() {
        XCTAssertEqual(makeSUT().navigationItem.title, Constants.App.POSTS_MSG)
    }
    
    func test_viewDidLoad_configuresPostsTV() {
        XCTAssertNotNil(makeSUT().postsTV)
    }
    
    func test_postsTV_rendersWithoutPosts() {
        let sut = makeSUT()
        XCTAssertEqual(sut.postsTV.numberOfRows(inSection: 0), sut.viewModel.postObjects.count)
    }
    
    func test_postsTV_rendersBlogPosts() {
        XCTAssertEqual(makeSUT(postObjects).postsTV.numberOfItems(), postObjects.count)
    }
    
    func test_postsTV_rendersCellForPostsTV() {
        XCTAssertEqual(makeSUT(postObjects).postsTV.title(at: 0), postObjects[0].title)
        XCTAssertEqual(makeSUT(postObjects).postsTV.bodyDescription(at: 0), postObjects[0].body)
        XCTAssertEqual(makeSUT(postObjects).postsTV.title(at: 1), postObjects[1].title)
        XCTAssertEqual(makeSUT(postObjects).postsTV.bodyDescription(at: 1), postObjects[1].body)
    }
    
    //MARK: - Helpers
    
    private func makeSUT(_ postObjects: [PostObject] = []) -> PostsViewController {
        let apiService = PostsAPIServiceMock()
        let viewModel = PostsViewModel(apiService: apiService)
        
        let sut = PostsViewController(viewModel: viewModel)
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
        let postsTableViewCell = cell(at: row) as! PostsTableViewCell
        return postsTableViewCell.titleLabel.text
    }
    
    func bodyDescription(at row: Int) -> String? {
        let postsTableViewCell = cell(at: row) as! PostsTableViewCell
        return postsTableViewCell.descriptionLabel.text
    }
}
