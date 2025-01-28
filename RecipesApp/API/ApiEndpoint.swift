//
//  ApiEndpoint.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import Foundation

enum ApiEndpoint {
    case recipes
    case malformed
    case empty
    
    var urlString: String {
        let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/"
        
        switch self {
        case .recipes:
            return baseURL + "recipes.json"
        case .malformed:
            return baseURL + "recipes-malformed.json"
        case .empty:
            return baseURL + "recipes-empty.json"
        }
    }
}
