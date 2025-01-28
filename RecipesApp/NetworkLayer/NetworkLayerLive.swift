//
//  NetworkLayerLive.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import Foundation

class NetworkLayerLive: NetworkLayer {
    
    /// Asynchronously get and decode JSON data for given object type for url using the URLSession.data(from:) convenience method
    /// - Parameter urlString: The URL string
    /// - Returns: Success/failure with object for given type if successful or error otherwise.
    func getJsonResponse<T: Decodable>(urlString: String, type: T.Type) async -> Result<T, Error> {
        guard let url = URL(string: urlString) else {
            return .failure(URLError(.badURL))
        }

        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url)
            
            // Make sure we've received a successful HTTP status back from the server
            // For this purpose, it's good as long as it's in the 200s
            guard let httpResponse = urlResponse as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
#if DEBUG
                print("Error \(String(describing: urlResponse))")
#endif
                return .failure(URLError(.badServerResponse))
            }
            
            // Now try to decode the JSON data...
            let modelObject = try JSONDecoder().decode(T.self, from: data)
            
            // Success!
            return .success(modelObject)
        } catch {
            // Network or Decoding error
#if DEBUG
            print("Error \(error.localizedDescription)")
#endif
            return .failure(error)
        }
    }
}
