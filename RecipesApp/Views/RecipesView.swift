//
//  RecipesView.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import SwiftUI

struct RecipesView: View {
    
    @StateObject var viewModel: RecipesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                switch viewModel.state {
                case .empty:
                    contentEmpty
                case .loading:
                    contentEmpty
                case .success(let recipes):
                    contentRecipes(recipes: recipes)
                case .error(let error):
                    contentError(error: error)
                }
            }
            .navigationTitle("recipes")
            .task {
                await viewModel.loadRecipes()
            }
        }
    }
    
    func contentRecipes(recipes: [Recipe]) -> some View {
        ForEach(recipes, id: \.self) { recipe in
            Text(recipe.name)
        }
    }

    var contentEmpty: some View {
        HStack(alignment: .top) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            Text("empty-list-message")
        }
    }
    
    func contentError(error: Error) -> some View {
        HStack(alignment: .top) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    RecipesView(viewModel: RecipesViewModel(networkLayer: NetworkLayerMock(),
                                            apiEndpoint: .recipes))
}
