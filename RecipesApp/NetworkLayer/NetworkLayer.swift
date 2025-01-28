//
//  NetworkLayer.swift
//  RecipesApp
//
//  Created by Oren Leavitt on 1/27/25.
//

import Foundation

protocol NetworkLayer {
    func getJsonResponse<T: Decodable>(urlString: String, type: T.Type) async -> Result<T, Error>
}
