//
//  SearchViewMode.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var products: [Product]
    @Published var numProducts = 0
    @Published var lastSearchTerm = ""
    
    @ObservedObject var cartViewModel: CartViewModel

    
    init(cartViewModel: CartViewModel) {
        self.products = []
        self.cartViewModel = cartViewModel
    }
    
    func getProducts(searchTerm: String) async {
        var productResult: ProductResult?
        do {
            productResult = try await APIService.shared.getProductData(search: searchTerm)
        } catch {
            print("ERROR", error)
        }
        
        let productResultUnwrapped = productResult ?? ProductResult.empty
        self.products = productResultUnwrapped.products
        self.numProducts = productResultUnwrapped.total
        self.lastSearchTerm = searchTerm
    }
    
    func calculateDiscountedPrice(product: Product) -> Double {
        return product.calculateDiscountedPrice()
    }
    
    
    
   
    
}
