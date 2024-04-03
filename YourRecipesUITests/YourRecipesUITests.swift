//
//  YourRecipesUITests.swift
//  YourRecipesUITests
//
//  Created by Alisina on 02.04.24.
//

import XCTest

class YourRecipesUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testIntroPageAndNavigation() throws {
        
                // Check if intro page is displayed
        let introPage = app.otherElements["introPage"]
        XCTAssertTrue(introPage.waitForExistence(timeout: 5), "Intro page should be visible")

        // Tap the start button
        let startButton = app.buttons["Let's Begin"]
        XCTAssertTrue(startButton.exists, "Start button should exist")
        startButton.tap()

        // Verify navigation to the main page
        let searchTextField = app.textFields["Enter your search phrases here"]
        XCTAssertTrue(searchTextField.exists, "Search text field should exist")
    }

    func testSearchRecipe() throws {
        
        // Check if intro page is displayed
        let introPage = app.otherElements["introPage"]
        XCTAssertTrue(introPage.waitForExistence(timeout: 5), "Intro page should be visible")

        // Tap the start button
        let startButton = app.buttons["Let's Begin"]
        XCTAssertTrue(startButton.exists, "Start button should exist")
        startButton.tap()

        // Verify navigation to the main page
        let searchTextField = app.textFields["Enter your search phrases here"]
        XCTAssertTrue(searchTextField.exists, "Search text field should exist")

        // Enter the search query
        searchTextField.tap()
        searchTextField.typeText("chicken") 

        // Tap the search button
        let searchButton = app.buttons["Search"]
        XCTAssertTrue(searchButton.exists, "Search button should exist")
        searchButton.tap()

        // Verify that the collection view is visible and contains cells
        let collectionView = app.collectionViews.firstMatch
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5), "Collection view should be visible")
        XCTAssertTrue(collectionView.cells.count > 0, "Collection view should contain cells")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}


