//
//  ProductImage.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct SmallProductImage: View {
    let product: Product
    let vm: FavoriteViewModel
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                AsyncImage(url: URL(string: product.thumbnail)) { $0
                    .resizable()
                    .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Spacer()
            }

            .frame(width: 150, height: 150)
            .accessibilityLabel("Image of" + product.title)

            HeartButton(product: product, vm: vm)
        }.padding(.trailing, 5)
    }
}

private struct HeartButton: View {
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
    SmallProductImage(product: Product.example, vm: FavoriteViewModel())
}
