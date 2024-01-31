//
//  FavoriteService.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import Foundation


class FavoriteService {
    static var shared = FavoriteService()
    private let favoritesKey = "favorites"
    
    func loadFavorites() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            print("No data saved.")
            return []
        }
        
        guard let favorites = try? JSONDecoder().decode([Product].self, from: data) else {
            print("Data failed to load.")
            return []
        }
        return favorites
    }
    
    func saveFavorites(favorites: [Product]) {
        guard let data = try? JSONEncoder().encode(favorites) else {
            print("Cannot encode data.")
            return
        }
        
        UserDefaults.standard.setValue(data, forKey: favoritesKey)
        print("successfully set favorites!")
    }
    
}
