//
//  RecipesError.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import Foundation

enum RecipesError: Error, LocalizedError {
    case malformedData
    
    var errorDescription: String? {
        switch self {
        case .malformedData:
            return String(localized: "error-could-not-read-data")
        }
    }
}
