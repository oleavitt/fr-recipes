//
//  Recipes.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import Foundation

/// The top level JSON object returned by the API call
struct Recipes: Decodable {
    let recipes: [Recipe]
}
