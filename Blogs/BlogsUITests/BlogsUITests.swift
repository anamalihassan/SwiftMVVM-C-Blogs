//
//  BlogsUITests.swift
//  BlogsUITests
//
//  Created by Ali Hassan on 10/05/2021.
//

import XCTest

class BlogsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewControllers() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let postsTV = app.tables["postsTV"]
        XCTAssertTrue(postsTV.exists)
        
        let postsTableViewCell_0 = postsTV.cells.element(matching: .cell, identifier: "postsTableViewCell_0")
        postsTableViewCell_0.tap()
        
        let titleLabel = app.staticTexts["titleLabel"]
        XCTAssertTrue(titleLabel.exists)
        
        let descriptionLabel = app.staticTexts["descriptionLabel"]
        XCTAssertTrue(descriptionLabel.exists)
        
        let commentsTV = app.tables["commentsTV"]
        XCTAssert(commentsTV.waitForExistence(timeout: 10))
        
        let commentsTableViewCell_0 = commentsTV.cells.element(matching: .cell, identifier: "commentsTableViewCell_0")
        XCTAssert(commentsTableViewCell_0.waitForExistence(timeout: 10))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
