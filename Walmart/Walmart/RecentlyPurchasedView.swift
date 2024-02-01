//
//  RecentlyViewedView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/31/24.
//

import SwiftUI

struct RecentlyPurchasedView: View {
    @ObservedObject var favoriteVM: FavoriteViewModel
    @ObservedObject var cartVM: CartViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // toolbar
            HStack {
                Text("Purchase Again")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(Color.white)
                Spacer()
                CartView(vm: cartVM, favoriteVM: favoriteVM)
            }
            .padding(.horizontal)
            .padding(.vertical, UIConstants.largePadding)
            .background(Color.blue)

            if cartVM.purchases.isEmpty {
                NoRecentlyViewedView()
            } else {
                ScrollView {
                    HStack {
                        Text("Price when purchased online  ⓘ")
                            .font(.footnote)
                        Spacer()
                    }.padding()
                    ForEach(cartVM.getPurchases().reversed()) { purchase in
                        HStack {
                            Text(purchase.date.formatted(date: .long, time: .shortened))
                                .font(.title3)
                                .fontWeight(.light)
                            Spacer()
                        }.padding(.horizontal)
                        
                        ForEach(purchase.products) { product in
                            SavedProductView(product: product, cartVM: cartVM, favoriteVM: favoriteVM)
                        }
                    }

                }
            }
        }
    }
}

private struct NoRecentlyViewedView: View {
    var body: some View {
        VStack {
            Text("You have not purchased anything yet.")
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
            Text("Go shop!")
            Spacer()
        }
        
    }
}

#Preview {
    RecentlyPurchasedView(favoriteVM: FavoriteViewModel(), cartVM: CartViewModel())
}
