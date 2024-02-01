//
//  FavoriteViewModel.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    // view model that handles favorites and recently viewed items.
    @Published var favorites: [Product] = []
    @Published var favoritesSet: Set<Product> = Set()
    
    @Published var recents: [Product] = [] // an ordered list of products viewed (reverse cronological)
    @Published var recentsSet: Set<Product> = Set()
    
    init() {
        favorites = FavoriteService.shared.loadFavorites()
        favoritesSet = Set(favorites)
        recents = RecentService.shared.loadRecents()
        recentsSet = Set(recents)
    }
    
    func registerProductView(product: Product) {
        if recentsSet.contains(product) {
            recents.remove(at: recents.firstIndex(of: product)!)
            recents.append(product)
        } else {
            recentsSet.insert(product)
            recents.append(product)
        }
        RecentService.shared.saveRecents(recents: recents)
    }
    
    func getRecentProducts() -> [Product] {
        return recents
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
