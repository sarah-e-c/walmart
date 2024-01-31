//
//  HeartButton.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct HeartButton: View {
    let product: Product

    @ObservedObject var vm: FavoriteViewModel
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                if vm.isProductFavorited(product: product) {
                    vm.removeFavorite(product: product)
                } else {
                    vm.favoriteProduct(product: product)
                }
            }
        } label: {
            HStack(alignment: .top) {
                VStack(alignment: .trailing) {
                    Image(systemName: vm.isProductFavorited(product: product) ? "heart.fill" : "heart")
                        .foregroundStyle(vm.isProductFavorited(product: product) ? Color.red : Color.primary)
                        .fontWeight(.light)
                        .padding(8)
                        .background()
                        .clipShape(Circle())
                }
            }
        }.accessibilityHint("Favorite this item.").offset(x: 120, y: -15)
    }
}
#Preview {
    HeartButton(product: Product.example, vm: FavoriteViewModel())
}
