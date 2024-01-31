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
    @Published var errorMessage = ""
    
    @ObservedObject var cartViewModel: CartViewModel
    @ObservedObject var favoriteViewModel: FavoriteViewModel

    
    init(cartViewModel: CartViewModel, favoriteViewModel: FavoriteViewModel) {
        self.products = []
        self.cartViewModel = cartViewModel
        self.favoriteViewModel = favoriteViewModel
        
        //injecting the same viewmodel to avoid inconsistency bugs
        self.cartViewModel.favoriteViewModel = favoriteViewModel
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
        self.products = productResultUnwrapped.products
        self.numProducts = productResultUnwrapped.total
        self.lastSearchTerm = searchTerm
    }
    
    func calculateDiscountedPrice(product: Product) -> Double {
        return product.calculateDiscountedPrice()
    }
    
    
    
   
    
}
