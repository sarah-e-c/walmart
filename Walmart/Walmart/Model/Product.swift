// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productResult = try? JSONDecoder().decode(ProductResult.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ProductResult: Codable {
    let products: [Product]
    let total, skip, limit: Int
    
    static let empty = ProductResult(products: [], total: 0, skip: 0, limit: 10)
}

// MARK: - Product
struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
    
    static var example = Product(id: 1, title: "Laptop", description: "laptop", price: 20, discountPercentage: 20, rating: 4.8, stock: 2, brand: "Lenovo", category: "bad", thumbnail: "https://cdn.dummyjson.com/product-images/9/1.jpg", images: [])
    
    func calculateDiscountedPrice() -> Double {
        return Double(self.price) * (100.0 - self.discountPercentage) / 100
    }
    
}
