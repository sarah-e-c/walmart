//
//  RecentlyViewedView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/31/24.
//

import SwiftUI

struct RecentlyViewedView: View {
    @ObservedObject var favoriteVM: FavoriteViewModel
    @ObservedObject var cartVM: CartViewModel
    var body: some View {
        VStack(spacing: 0) {
            // toolbar
            HStack {
                Text("Recently viewed")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(Color.white)
                Spacer()
                CartView(vm: cartVM, favoriteVM: favoriteVM)
            }
            .padding(.horizontal)
            .padding(.vertical, UIConstants.largePadding)
            .background(Color.blue)

            if favoriteVM.recents.isEmpty {
                NoRecentlyViewedView()
            } else {
                ScrollView {
                    HStack {
                        Text("Price when purchased online  ⓘ")
                            .font(.footnote)
                        Spacer()
                    }.padding()
                    
                    ForEach(favoriteVM.getRecentProducts().reversed()) { product in
                        SavedProductView(product: product, cartVM: cartVM, favoriteVM: favoriteVM)
                        Divider()
                    }
                }
            }
        }
    }
}

private struct NoRecentlyViewedView: View {
    var body: some View {
        VStack {
            Text("You have no recently viewed products :( ")
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
            Text("Go shop!")
            Spacer()
        }
        
    }
}

#Preview {
    RecentlyViewedView(favoriteVM: FavoriteViewModel(), cartVM: CartViewModel())
}
