//
//  ContentView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    // this is not observed to prevent a rerendering of the cart view
    var favoriteVM: FavoriteViewModel
    var cartVM: CartViewModel
    var searchVM: SearchViewModel
    init() {
        favoriteVM = FavoriteViewModel()
        cartVM = CartViewModel(favoriteViewModel: favoriteVM)
        searchVM = SearchViewModel(cartViewModel: cartVM, favoriteViewModel: favoriteVM)
    }
    var body: some View {
        TabView {
            Text("Placeholder")
                .tabItem {
                    TabLabel("storefront", "Shop")
                }
            FavoritesView(favoriteVM: favoriteVM, cartVM: cartVM)
                .tabItem { TabLabel("heart", "My Items") }
            SearchView(vm: searchVM)
                .tabItem {
                    TabLabel("magnifyingglass", "Search")
                }
            Text("Placeholder")
                .tabItem { TabLabel("circle.grid.2x2", "Services") }
            Text("Placeholder")
                .tabItem { TabLabel("person.crop.circle", "Account") }
        }
    }
}

#Preview {
    ContentView()
}
