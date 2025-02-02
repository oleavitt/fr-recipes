//
//  RecipesViewModel.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import SwiftUI

class RecipesViewModel: ObservableObject {
    let networkLayer: NetworkLayer
    var apiEndpoint: ApiEndpoint

    enum State {
        case empty
        case loading
        case success([Recipe])
        case error(Error)
        
        var isEmpty: Bool {
            switch self {
            case .empty: return true
            default: return false
            }
        }
    }
        
    @Published var state: State = .empty
            
    init(networkLayer: NetworkLayer, apiEndpoint: ApiEndpoint = .recipes) {
        self.networkLayer = networkLayer
        self.apiEndpoint = apiEndpoint
    }
    
    @MainActor
    func loadRecipes() async {
        state = .loading
        
        let result = await networkLayer.getJsonResponse(urlString: apiEndpoint.urlString, type: Recipes.self)
        switch result {
        case .success(let recipes):
#if DEBUG
            print("loadRecipes: Received \(recipes.recipes.count) recipes")
#endif
            state = recipes.recipes.isEmpty ? .empty : .success(recipes.recipes)
        case .failure(let error):
#if DEBUG
            print("loadRecipes: Error \(error.localizedDescription)")
#endif
            state = .error(error is DecodingError ? RecipesError.malformedData : error)
        }
    }
}
