//
//  YourRecipesTests.swift
//  YourRecipesTests
//
//  Created by Alisina on 02.04.24.
//

import XCTest
@testable import YourRecipes

final class YourRecipesTests: XCTestCase {
    var viewModel: RecipesViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RecipesViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testFetchData() throws {
        let expectation = XCTestExpectation(description: "Fetch data expectation")

        viewModel.fetchData(params: "chicken") { result in
            switch result {
            case .success(let searchResult):
                XCTAssertNotNil(searchResult, "Search result should not be nil")
                XCTAssertFalse(searchResult.hits!.isEmpty, "Search result should contain hits")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error occurred: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchResult() throws {
        let hit = Hit(recipe: Recipe(uri: "123", label: "Test Recipe", image: "test_image", images: Images(thumbnail: ImageDetail(url: "thumbnail_url", width: 100, height: 100), small: ImageDetail(url: "small_url", width: 200, height: 200), regular: ImageDetail(url: "regular_url", width: 300, height: 300), large: ImageDetail(url: "large_url", width: 400, height: 400)), source: "Test Source", url: "test_url", shareAs: "test_share_url", yield: 2.0, dietLabels: [], healthLabels: [], cautions: [], ingredientLines: [], ingredients: [], calories: 200.0, totalCO2Emissions: 0.0, co2EmissionsClass: "", totalWeight: 100.0, totalTime: 30.0, cuisineType: [], mealType: [], dishType: [], totalNutrients: TotalNutrients(enercKcal: NutrientDetail(label: "Energy", quantity: 100.0, unit: "kcal"), fat: NutrientDetail(label: "Fat", quantity: 10.0, unit: "g"), fasat: NutrientDetail(label: "Saturated Fat", quantity: 5.0, unit: "g"), fatrn: NutrientDetail(label: "Trans Fat", quantity: 2.0, unit: "g"), totalDaily: DailyNutrientDetail(enercKcal: NutrientDetail(label: "Energy", quantity: 10.0, unit: "%"), fat: NutrientDetail(label: "Fat", quantity: 20.0, unit: "%"), fasat: NutrientDetail(label: "Saturated Fat", quantity: 10.0, unit: "%"))), digest: []), _links: nil)
        
        let searchResult = SearchResult(from: 0, to: 1, count: 1, _links: Links(next: RecipeLink(title: "Next", href: "next_url")), hits: [hit])

        XCTAssertNotNil(searchResult, "Search result should not be nil")
        XCTAssertEqual(searchResult.hits!.count, 1, "Number of hits should be 1")
        XCTAssertEqual(searchResult.hits!.first??.recipe?.label, "Test Recipe", "Label of first recipe should match")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
