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
                }.accessibilityHint("Adds" + product.title + " to cart.")
            } else {
                HStack {
                    Button {
                        withAnimation {
                            vm.removeFromCart(product: product)
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")

                    }.accessibilityHint("Removes" + product.title + "from cart.")
                    Spacer()
                    Text(String(vm.getProductQuantity(product: product)))
                    Spacer()
                    Button {
                        vm.addToCart(product: product)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }.accessibilityHint("Adds" + product.title + " to cart.")
                }
            }

        }.foregroundStyle(Color.white)
            .font(isLarge ? .body : .subheadline)
            .fontWeight(isLarge ? .heavy : .bold)
            .padding(isLarge ? UIConstants.largePadding : UIConstants.medPadding)
            .background(Color.blue, in: .rect(cornerRadius: 25.0))
    }
}

#Preview {
    AddToCartButton(vm: CartViewModel(), product: Product.example, isLarge: false)
}
