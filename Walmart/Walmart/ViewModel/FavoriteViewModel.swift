//
//  FavoriteViewModel.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var favorites: [Product] = []
    @Published var favoritesSet: Set<Product> = Set()
    
    init() {
        favorites = FavoriteService.shared.loadFavorites()
        favoritesSet = Set(favorites)
    }
    
    func getFavoriteProducts() -> [Product] {
        return self.favorites
    }
    
    func favoriteProduct(product: Product) {
        guard !favoritesSet.contains(product) else {return}
        favorites.append(product)
        favoritesSet.insert(product)
        FavoriteService.shared.saveFavorites(favorites: favorites)
    }
    
    func removeFavorite(product: Product) {
        guard favoritesSet.contains(product) else {return}
        favorites.remove(at: favorites.firstIndex(of: product)!)
        favoritesSet.remove(product)
        FavoriteService.shared.saveFavorites(favorites: favorites)
    }
    
    func isProductFavorited(product: Product) -> Bool {
        return favoritesSet.contains(product)
    }
}
