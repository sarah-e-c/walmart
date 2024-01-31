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
    @ObservedObject var vm: SearchViewModel
    var body: some View {
        VStack(alignment: .leading) {
            // best seller tag
            if product.rating >= 4.4 {
                Text("Best Seller")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    .padding(.horizontal)
            }
            HStack(alignment: .top) {
                // image and heart Button
                Button {
                    isDetailsPresented.toggle()
                } label: {
                    SmallProductImage(product: product, vm:vm.favoriteViewModel)
                }
                

                // product details
                VStack(alignment: .leading) {
                    Text("Sponsored")
                        .font(.caption)
                        .fontWeight(.light)
                        .opacity(0.6)
                        .padding(.bottom, 2)
                    
                    ProductPriceView(product: product)

                    ProductTitleView(product:  product)

                    StarsView(product: product)
                        .padding(.bottom, 8)

                    // Walmart Plus advertisement
                    WalmartPlusView()

                    Text("Free shipping, arrives ")
                        .fontWeight(.light)
                        .font(.caption) + Text("in 2 days")
                        .font(.caption).bold()

                    // add to cart button
                    AddToCartButton(vm: vm.cartViewModel, product: product, isLarge: false)
                        .padding(.top, 8)
                }
            }.padding()
                .sheet(isPresented: $isDetailsPresented, content: {
                    ProductDetailView(product: product, cartVM: vm.cartViewModel, favoriteVM: vm.favoriteViewModel)
                })
        }
    }
}




#Preview {
    SearchProductView(product: Product.example, vm: SearchViewModel(cartViewModel: CartViewModel(), favoriteViewModel: FavoriteViewModel()))
}








