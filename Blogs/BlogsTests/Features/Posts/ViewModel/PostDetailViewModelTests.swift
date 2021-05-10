//
//  PostDetailViewModelTests.swift
//  BlogsTests
//
//  Created by Ali Hassan on 10/05/2021.
//

import XCTest
@testable import Blogs

class PostDetailViewModelTests: XCTestCase {
    
    var sut: PostDetailViewModel!
    var apiService: PostsAPIServiceMock!
    var postObject: PostObject!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        postObject = StubGenerator().stubBlogPosts()[0]
        apiService = PostsAPIServiceMock()
        sut = PostDetailViewModel(postObject: postObject, apiService: apiService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        apiService = nil
        super.tearDown()
    }
    
    func test_fetch_comments() {
        sut.getBlogPostComments(postId: postObject.id)
    
        // Assert
        XCTAssert(apiService!.isGetBlogPostCommentsCalled)
    }
    
    func test_comments_cells() {

        
        let expect = XCTestExpectation(description: "comments count")
        sut.didFinishFetch = { () in
            expect.fulfill()
        }
        
        sut.getBlogPostComments(postId: postObject.id)
        
        // commentObjects count is equal to the number of comments data
        XCTAssertEqual( sut.commentObjects.count, StubGenerator().stubBlogPostComments().count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }

}
