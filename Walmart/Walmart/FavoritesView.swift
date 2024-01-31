//
//  FavoritesView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoriteVM: FavoriteViewModel
    @ObservedObject var cartVM: CartViewModel
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("My Favorite Products")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(Color.white)
                Spacer()
                CartView(vm: cartVM)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color.blue)

            if favoriteVM.favorites.isEmpty {
                NoFavoritesView()
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack(alignment: .lastTextBaseline) {
                            Text(favoriteVM.favorites.count > 1 ? "\(favoriteVM.favorites.count) Favorite Products" : "1 Favorite Product")
                                .font(.title3)
                                .bold()

                            Spacer()
                        }
                        Text("Price when purchased online  ⓘ")
                            .font(.caption)
                    }.padding()
                    ForEach(favoriteVM.getFavoriteProducts()) { product in
                        FavoriteProductView(product: product, cartVM: cartVM, favoriteVM: favoriteVM)
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesView(favoriteVM: FavoriteViewModel(), cartVM: CartViewModel())
}

private struct NoFavoritesView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("You have no favorite products :(")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            Text("Go shop!")
                .font(.headline)
            Spacer()
        }
    }
}
