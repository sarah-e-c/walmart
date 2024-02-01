//
//  CartProductView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct CartProductView: View {
    let product: Product
    @ObservedObject var vm: CartViewModel
    @ObservedObject var favoriteVM: FavoriteViewModel
    var body: some View {
        HStack(alignment: .top, spacing: UIConstants.largePadding) {
            SmallProductImage(product: product, vm: favoriteVM)
                .padding(.top, UIConstants.medPadding)
            VStack(alignment: .leading, spacing: UIConstants.medPadding) {
                ProductPriceView(product: product)
                    .padding(.bottom, UIConstants.smallPadding)
                ProductTitleView(product: product)
                    .padding(.bottom, UIConstants.smallPadding)
                StarsView(product: product)
                    .padding(.bottom, UIConstants.smallPadding)

                Text("Quantity")
                    .font(.headline)

                // quantity dial
                HStack {
                    Button {
                        withAnimation { vm.removeFromCart(product: product) }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                    }
                    Text(String(vm.getProductQuantity(product: product)))

                    Button {
                        withAnimation { vm.addToCart(product: product) }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    CartProductView(product: Product.example, vm: CartViewModel(), favoriteVM: FavoriteViewModel())
}
