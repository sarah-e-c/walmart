//
//  ProductView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import SwiftUI

struct SearchProductView: View {
    let product: Product
    @State private var isDetailsPresented = false
    @ObservedObject var favoriteVM: FavoriteViewModel
    @ObservedObject var cartVM: CartViewModel
    var body: some View {
        VStack(alignment: .leading) {
            // best seller tag
            if product.rating >= 4.6 {
                PopularPickTag()
                    .padding(.bottom, UIConstants.medPadding)
            } else if product.rating >= 4.4 {
                BestSellerTag()
                    .padding(.bottom, UIConstants.medPadding)
            }

            HStack(alignment: .top, spacing: UIConstants.largePadding) {
                // image and heart Button
                Button {
                    isDetailsPresented.toggle()
                    favoriteVM.registerProductView(product: product)
                } label: {
                    SmallProductImage(product: product, vm: favoriteVM)
                }.padding(.top, UIConstants.largePadding)

                // product details
                VStack(alignment: .leading, spacing: UIConstants.medPadding) {
                    Text("Sponsored")
                        .font(.caption)
                        .fontWeight(.light)
                        .opacity(0.6)

                    ProductPriceView(product: product)
                        .padding(.bottom, UIConstants.smallPadding)

                    ProductTitleView(product: product)
                        .padding(.bottom, UIConstants.smallPadding)

                    StarsView(product: product)
                        .padding(.bottom, UIConstants.smallPadding)

                    // Walmart Plus advertisement
                    WalmartPlusView()

                    Text("Free shipping, arrives ")
                        .fontWeight(.light)
                        .font(.caption) + Text("in 2 days")
                        .font(.caption).bold()

                    // add to cart button
                    AddToCartButton(vm: cartVM, product: product, isLarge: false)
                        .padding(.top, UIConstants.largePadding)
                }
            }
            .sheet(isPresented: $isDetailsPresented, content: {
                ProductDetailView(product: product, cartVM: cartVM, favoriteVM: favoriteVM)
            })
        }.padding(.horizontal)
    }
}

private struct BestSellerTag: View {
    var body: some View {
        Text("Best seller")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundStyle(Color.blue)
            .padding(UIConstants.medPadding)
            .background(Color.blue.opacity(0.1), in: .rect(cornerRadius: 5.0))
    }
}

private struct PopularPickTag: View {
    var body: some View {
        Text("Popular pick")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .padding(UIConstants.medPadding)
            .background(Color.popularpickcolor, in: .rect(cornerRadius: 5.0))
    }
}

#Preview {
    SearchProductView(product: Product.example, favoriteVM: FavoriteViewModel(), cartVM: CartViewModel())
}
