//
//  CommentsTableViewCellTests.swift
//  BlogsTests
//
//  Created by Ali Hassan on 10/05/2021.
//

import XCTest
@testable import Blogs

class CommentsTableViewCellTests: XCTestCase {
    
    func test_setup_rendersCorrectData() {
        let sut = makeSUT()
        let comments = StubGenerator().stubBlogPostComments()
        let commentObject = comments[0]
        sut.configureCell(data: commentObject)
        
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertEqual(sut.titleLabel.text, commentObject.name)
        XCTAssertEqual(sut.descriptionLabel.text, commentObject.body)
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> CommentsTableViewCell {
        let cell = CommentsTableViewCell()
        return cell
    }
    
}
