//
//  PostsTableViewCellTests.swift
//  BlogsTests
//
//  Created by Ali Hassan on 10/05/2021.
//

import XCTest
@testable import Blogs

class PostsTableViewCellTests: XCTestCase {
    
    func test_setup_rendersCorrectData() {
        let sut = makeSUT()
        let posts = StubGenerator().stubBlogPosts()
        let postObject = posts[0]
        sut.configureCell(data: postObject)
        
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertEqual(sut.titleLabel.text, postObject.title)
        XCTAssertEqual(sut.descriptionLabel.text, postObject.body)
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> PostsTableViewCell {
        let cell = PostsTableViewCell()
        return cell
    }
    
}
