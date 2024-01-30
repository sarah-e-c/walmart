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
                                        Text("Total Price: ").font(.title3) +
                                            Text("$" + String(format: "%.2f", vm.cartPrice))
                                            .bold()
                                            .foregroundStyle(Color.discountgreen)
                                            .font(.title)
                                        Text("Items: \(vm.cartSize)")
                                    }.padding()
                                    
                                
                                
                                ForEach(vm.cartItems) { product in
                                    CartProductView(product: product, vm: vm)
                                    Divider()
                                }
                                
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
            Text("Time to start Shopping!")
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
