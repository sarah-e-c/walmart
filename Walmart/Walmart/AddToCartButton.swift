//
//  AddToCartButton.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct AddToCartButton: View {
    @ObservedObject var vm: CartViewModel
    let product: Product
    let isLarge: Bool
    init(vm: CartViewModel, product: Product) {
        self.vm = vm
        self.product = product
        isLarge = true
    }

    init(vm: CartViewModel, product: Product, isLarge: Bool) {
        self.vm = vm
        self.product = product
        self.isLarge = isLarge
    }

    var body: some View {
        Group {
            if vm.getProductQuantity(product: product) == 0 {
                Button {
                    withAnimation {
                        vm.addToCart(product: product)
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Add to cart")
                        Spacer()
                    }
                }
            } else {
                HStack {
                    Button {
                        withAnimation {
                            vm.removeFromCart(product: product)
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                    }
                    Spacer()
                    Text(String(vm.getProductQuantity(product: product)))
                    Spacer()
                    Button {
                        vm.addToCart(product: product)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }

        }.foregroundStyle(Color.white)
            .font(isLarge ? .body : .subheadline)
            .fontWeight(.heavy)
            .padding(isLarge ? 12 : 8)
            .padding(.horizontal)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    AddToCartButton(vm: CartViewModel(), product: Product.example)
}
