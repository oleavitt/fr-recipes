//
//  RecipesViewModelTests.swift
//  RecipesAppTests
//
//  Created by Oren Leavitt on 1/26/25.
//

import XCTest
@testable import RecipesApp

final class RecipesViewModelTests: XCTestCase {

    var viewModel = RecipesViewModel(networkLayer: NetworkLayerMock())
    
    override func setUpWithError() throws {
        viewModel = RecipesViewModel(networkLayer: NetworkLayerMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.state.isEmpty)
    }
 
    func testLoadRecipes() async {
        await viewModel.loadRecipes()
        
        XCTAssertFalse(viewModel.state.isEmpty)
        if case let .success(recipes) = viewModel.state {
            XCTAssertEqual(recipes.count, 10)
            
            if let firstRecipe = recipes.first {
                XCTAssertEqual(firstRecipe.cuisine, "Malaysian")
                XCTAssertEqual(firstRecipe.name, "Apam Balik")
            } else {
                XCTFail("Could not get first recipe")
            }
            
            if let lastRecipe = recipes.last {
                XCTAssertEqual(lastRecipe.cuisine, "Italian")
                XCTAssertEqual(lastRecipe.name, "Budino Di Ricotta")
            } else {
                XCTFail("Could not get last recipe")
            }
        } else {
            XCTFail("loadRecipes() did not complete with 'success' state")
        }
    }
    
    func testLoadRecipesMalformed() async {
        await viewModel.loadRecipes(apiEndpoint: .malformed)
        
        if case let .error(error) = viewModel.state {
            XCTAssertEqual(error.localizedDescription, "Well, dang… There was an error loading your recipes. Please try again!")
        } else {
            XCTFail("loadRecipes(apiEndpoint: .malformed) did not complete with 'error' state")
        }
    }
    
    func testLoadRecipesEmpty() async {
        await viewModel.loadRecipes(apiEndpoint: .empty)
        
        XCTAssertTrue(viewModel.state.isEmpty)
    }
}
