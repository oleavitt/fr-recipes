//
//  RecipesViewModel.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import SwiftUI

class RecipesViewModel: ObservableObject {
    let networkLayer: NetworkLayer
    
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
            
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    @MainActor
    func loadRecipes(apiEndpoint: ApiEndpoint = .recipes) async {
        state = .loading
        
        let result = await networkLayer.getJsonResponse(urlString: apiEndpoint.urlString, type: Recipes.self)
        switch result {
        case .success(let recipes):
            state = recipes.recipes.isEmpty ? .empty : .success(recipes.recipes)
        case .failure(let error):
            state = .error(error)
        }
    }
}
