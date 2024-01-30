//
//  ContentView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Placeholder")
                .tabItem {
                    TabLabel("storefront", "Shop")
                }
            Text("Placeholder")
                .tabItem { TabLabel("heart", "My Items") }
            SearchView(vm: SearchViewModel(cartViewModel: CartViewModel()))
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
