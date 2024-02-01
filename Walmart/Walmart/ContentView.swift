//
//  ContentView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    var favoriteVM: FavoriteViewModel = FavoriteViewModel()
    var cartVM: CartViewModel = CartViewModel()
    var searchVM: SearchViewModel = SearchViewModel()
    
    var body: some View {
        TabView {
            Text("Hello, world!")
                .tabItem {
                    TabLabel("storefront", "Shop")
                }
            FavoritesView(favoriteVM: favoriteVM, cartVM: cartVM)
                .tabItem { TabLabel("heart", "My Items") }
            SearchView(vm: searchVM, favoriteVM: favoriteVM, cartVM: cartVM)
                .tabItem {
                    TabLabel("magnifyingglass", "Search")
                }
            RecentlyViewedView(favoriteVM: favoriteVM, cartVM: cartVM)
                .tabItem { TabLabel("circle.grid.2x2", "Services") }
            RecentlyPurchasedView(favoriteVM: favoriteVM, cartVM: cartVM)
                .tabItem { TabLabel("person.crop.circle", "Account") }
        }.preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
