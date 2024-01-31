//
//  FavoriteProductView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct FavoriteProductView: View {
    let product: Product
    @ObservedObject var cartVM: CartViewModel
    @ObservedObject var favoriteVM: FavoriteViewModel
    @State private var isSheetPresented = false
    var body: some View {
        HStack(alignment: .top) {
            Button {
                isSheetPresented.toggle()
            } label: {
                SmallProductImage(product: product, vm: favoriteVM)
            }
            
            VStack(alignment: .leading) {
                ProductTitleView(product: product)
                ProductPriceView(product: product)
                StarsView(product: product)
                    .padding(.bottom, 3)
                WalmartPlusView()
                AddToCartButton(vm: cartVM, product: product, isLarge: false)
            }
            

        }.padding()
            .sheet(isPresented: $isSheetPresented) {
                ProductDetailView(product: product, cartVM: cartVM, favoriteVM: favoriteVM)
            }
        
        
    }
}

#Preview {
    FavoriteProductView(product: Product.example, cartVM: CartViewModel(), favoriteVM: FavoriteViewModel())
}
