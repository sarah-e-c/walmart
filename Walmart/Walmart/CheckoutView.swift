//
//  Checko9utView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var vm: CartViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                        Text("Return")
                            .font(.headline)
                    }
                    Spacer()
                }.foregroundStyle(Color.white)
                    .padding()
                    .background(Color.blue)

                ScrollView {
                    HStack {
                        if vm.cartSize > 0 {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text("Total Price: ").font(.title3).fontWeight(.light) +
                                        Text("$" + String(format: "%.2f", vm.cartPrice))
                                        .bold()
                                        .font(.title3)
                                        
                                        
                                        
                                    Text("Items: \(vm.cartSize)")
                                        .fontWeight(.light)
                                        
                                }.padding()

                                ForEach(vm.cartItems) { product in
                                    CartProductView(product: product, vm: vm)
                                    Divider()
                                }
                                
                                VStack {
                                    HStack {
                                        Text("Items")
                                        Spacer()
                                        Text(String(vm.cartSize))
                                    }
                                    HStack {
                                        Text("Subtotal")
                                        Spacer()
                                        Text("$\(vm.cartUndiscountedPrice).00")
                                    }
                                    HStack {
                                        Text("Savings")
                                        Spacer()
                                        Text("-$" + String(format: "%.2f", vm.positiveCartDiscount))
                                            .foregroundStyle(Color.discountgreen)
                                    }
                                    HStack {
                                        Text("Total")
                                        Spacer()
                                        Text("$" + String(format: "%.2f", vm.cartPrice))
                                    }
                                }.padding().border(Color.blue)
                                    .padding()
                                    .fontWeight(.light)
                                

                                Button {
                                    vm.checkoutItems()
                                    dismiss()
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Checkout Items")
                                            .foregroundStyle(Color.white)
                                            .bold()
                                            .padding()
                                            .padding(.horizontal)
                                        Spacer()
                                    }.background(.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                        .padding()
                                }
                            }

                        } else {
                            EmptyCartView()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CheckoutView(vm: CartViewModel())
}

private struct EmptyCartView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("emptycart")
                .resizable()
                .scaledToFit()
                .accessibilityLabel("Image of a Walmart shopping cart.")
            Text("Time to start shopping!")
                .font(.title)
                .bold()
                .padding(.bottom, 2)
            Text("Your cart is empty")
                .font(.title3)
                .bold()
                .padding(.bottom, 6)
            Text("Fill it up with savings from around the app.")
        }
    }
}
