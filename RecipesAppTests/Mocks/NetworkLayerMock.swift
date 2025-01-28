//
//  NetworkLayerMock.swift
//  RecipesAppTests
//
//  Created by Oren Leavitt on 1/27/25.
//

import Foundation
@testable import RecipesApp

class NetworkLayerMock: NetworkLayer {
    
    /// Asynchronously get and decode JSON data for given object type from a mock .json data source
    /// - Parameter urlString: The URL string
    /// - Returns: Success/failure with object for given type if successful or error otherwise.
    func getJsonResponse<T: Decodable>(urlString: String, type: T.Type) async -> Result<T, Error> {
        
        // Determine which mock JSON resource to use based on which of the three endpoints is being requested
        let resourceName: String
        if urlString.contains("empty") {
            resourceName = "EmptyRecipes"
        } else if urlString.contains("malformed") {
            resourceName = "TenRecipesMalformed"
        } else {
            resourceName = "TenRecipes"
        }
        
        // Get the unit test target bundle and resource url
        let bundle = Bundle(for: NetworkLayerMock.self)
        guard let url = bundle.url(forResource: resourceName, withExtension: "json") else {
            return .failure(URLError(.badURL))
        }
        
        do {
            // Load mock data from the bundle resource
            let data = try Data(contentsOf: url)
            
            // Now try to decode the JSON data...
            let modelObject = try JSONDecoder().decode(T.self, from: data)
            
            // Success!
            return .success(modelObject)
        } catch {
            // Data or Decoding error
#if DEBUG
            print("Error \(error.localizedDescription)")
#endif
            return .failure(error)
        }
    }
}
