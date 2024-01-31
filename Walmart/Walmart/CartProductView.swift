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
    var body: some View {
        HStack(alignment: .top) {
            SmallProductImage(product: product, vm:vm.favoriteViewModel ?? FavoriteViewModel())
            VStack(alignment: .leading) {
                ProductPriceView(product: product)
                ProductTitleView(product: product)
                StarsView(product: product)
                    .padding(.bottom, 3)
                
                Text("Quantity")
                    .font(.headline)
                    .padding(.bottom, 3)
                HStack {
                    Button {
                        withAnimation{vm.removeFromCart(product: product)}
                    } label: {
                        Image(systemName: "minus.circle.fill")
                    }
                    Text(String(vm.getProductQuantity(product: product)))
                    
                    Button {
                        withAnimation {
                            vm.addToCart(product: product)
                        }
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    CartProductView(product: Product.example, vm: CartViewModel())
}
