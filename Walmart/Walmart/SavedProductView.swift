//
//  FavoriteProductView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct SavedProductView: View {
    let product: Product
    @ObservedObject var cartVM: CartViewModel
    @ObservedObject var favoriteVM: FavoriteViewModel
    @State private var isSheetPresented = false
    var body: some View {
        HStack(alignment: .top, spacing: UIConstants.largePadding) {
            Button {
                isSheetPresented.toggle()
                favoriteVM.registerProductView(product: product)
            } label: {
                SmallProductImage(product: product, vm: favoriteVM)
            }

            VStack(alignment: .leading, spacing: UIConstants.medPadding) {
                ProductTitleView(product: product)
                    .padding(.bottom, UIConstants.smallPadding)
                ProductPriceView(product: product)
                    .padding(.bottom, UIConstants.smallPadding)
                StarsView(product: product)
                    .padding(.bottom, UIConstants.smallPadding)
                WalmartPlusView()
                    .padding(.bottom, UIConstants.smallPadding)
                AddToCartButton(vm: cartVM, product: product, isLarge: false)
            }

        }.padding()
            .sheet(isPresented: $isSheetPresented) {
                ProductDetailView(product: product, cartVM: cartVM, favoriteVM: favoriteVM)
            }
    }
}

#Preview {
    SavedProductView(product: Product.example, cartVM: CartViewModel(), favoriteVM: FavoriteViewModel())
}
