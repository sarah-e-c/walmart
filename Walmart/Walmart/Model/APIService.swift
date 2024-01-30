//
//  APIService.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import Foundation

class APIService {
    enum APIError: Error {
        case invalidResponse
        case invalidURL
        case badRequest
    }

    private let endpoint = "https://dummyjson.com"
    
    private let searchEndpoint = "/products/search?q="
    
    static var shared = APIService()
    
    func getProductData(search: String) async throws -> ProductResult {
        let urlString = endpoint + searchEndpoint + search
        guard let url = URL(string: urlString) else {
            print("invalid url!")
            throw APIError.invalidURL
        }
        
        let (data, responseCode) = try await URLSession.shared.data(from: url)
        
        let httpResponse = responseCode as! HTTPURLResponse
        guard (200 ... 299).contains(httpResponse.statusCode) else {
            print("bad request!")
            throw APIError.badRequest
        }
        
        let productResult = try? JSONDecoder().decode(ProductResult.self, from: data)
        
        guard let productResult = productResult else {
            print("invalid response!")
            throw APIError.invalidResponse
        }
        
        return productResult
    }
}
