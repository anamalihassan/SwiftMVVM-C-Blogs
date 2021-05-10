//
//  PostsViewModelTests.swift
//  BlogsTests
//
//  Created by Ali Hassan on 10/05/2021.
//

import XCTest
@testable import Blogs

class PostsViewModelTests: XCTestCase {
    
    var sut: PostsViewModel!
    var apiService: PostsAPIServiceMock!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        apiService = PostsAPIServiceMock()
        sut = PostsViewModel(apiService: apiService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        apiService = nil
        super.tearDown()
    }
    
    func test_fetch_posts() {
        sut.getBlogPosts()
    
        // Assert
        XCTAssert(apiService!.isGetBlogPostsCalled)
    }
    
    func test_posts_cells() {

        
        let expect = XCTestExpectation(description: "posts count")
        sut.didFinishFetch = { () in
            expect.fulfill()
        }
        
        sut.getBlogPosts()
        
        // postObjects count is equal to the number of posts data
        XCTAssertEqual( sut.postObjects.count, StubGenerator().stubBlogPosts().count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }

}
