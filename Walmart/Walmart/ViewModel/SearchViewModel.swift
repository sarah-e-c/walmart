//
//  SearchViewMode.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var numProducts = 0
    @Published var lastSearchTerm = ""
    @Published var errorMessage = ""
    
    @Published var startPrice: Double? = nil
    @Published var endPrice: Double? = nil
    @Published var sortingKey: SortingOptionKey = .none
    
    var isFilterEnabled: Bool {
        return startPrice != nil ||  endPrice != nil || sortingKey != .none
    }
    
    
    
    let sortingClosures: [SortingOptionKey: (Product, Product) -> Bool] = [
        .alphabetical: {$0.title < $1.title},
        .priceHighToLow: {$0.price > $1.price},
        .priceLowToHigh: {$0.price < $1.price},
        .ratingHighToLow: {$0.rating > $1.rating},
        .ratingLowToHigh: {$0.rating < $1.rating},
        .none: {$0.rating > $1.rating},
    ]
    

    
    func filterAndSortProducts(products: [Product]) {
        let filteredProducts = products.filter({$0.calculateDiscountedPrice() >= startPrice ?? 0 && $0.calculateDiscountedPrice() <= endPrice ?? Double.infinity })
        
        let sortedProducts: [Product]
        if sortingKey != .none {
            sortedProducts = filteredProducts.sorted(by: sortingClosures[sortingKey] ?? {$0.price > $1.price})
        } else {
            sortedProducts = filteredProducts
        }
        
        self.products = sortedProducts
        self.numProducts = sortedProducts.count
    }
    
    func getProducts(searchTerm: String) async {
        errorMessage = ""
        var productResult: ProductResult?
        do {
            productResult = try await APIService.shared.getProductData(search: searchTerm)
        } catch {
            errorMessage = "\(error)"
            print("ERROR", error)
        }
        
        let productResultUnwrapped = productResult ?? ProductResult.empty
        
        filterAndSortProducts(products: productResultUnwrapped.products)
        self.lastSearchTerm = searchTerm
    }
    
    func calculateDiscountedPrice(product: Product) -> Double {
        return product.calculateDiscountedPrice()
    }
    
    
    
   
    
}
