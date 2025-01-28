//
//  Recipe.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import Foundation

/// Represents a single recipe in the list of recipes returned in the API response
struct Recipe: Decodable {
    let uuid: UUID
    
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youTubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youTubeUrl = "youtube_url"
    }
}

/// Hashable id for List view
extension Recipe: Hashable {
    var id: UUID {
        uuid
    }
}
