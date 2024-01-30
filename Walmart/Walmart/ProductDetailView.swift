//
//  ProductDetailView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @ObservedObject var cartVM: CartViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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

            ZStack {
                ScrollView {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.brand)
                                .font(.caption)
                                .underline()
                            Text(product.title)
                                .font(.title)
                                .fontWeight(.light)
                        }.padding()
                        Spacer()
                    }
                    TabView {
                        ForEach(product.images.reversed(), id: \.self) { imageURL in
                            AsyncImage(url: URL(string: imageURL)) {
                                image in
                                image.resizable()
                                    .scaledToFit()

                            } placeholder: {
                                ProgressView()
                            }.accessibilityLabel("Image of" + product.title)
                        }
                    }.tabViewStyle(PageTabViewStyle())
                        .frame(height: 250)

                    VStack(alignment: .leading) {
                        HStack {
                            ProductPriceView(product: product)
                            StarsView(product: product)
                        }

                        Text(product.description)
                    }.padding()
                }
                AbsoluteAddToCartButton(vm: cartVM, product: product)
            }
        }
    }
}

#Preview {
    ProductDetailView(product: Product.example, cartVM: CartViewModel())
}

private struct AbsoluteAddToCartButton: View {
    @ObservedObject var vm: CartViewModel
    let product: Product
    var body: some View {
        VStack {
            Spacer()
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
                        .foregroundStyle(Color.white)
                        .fontWeight(.heavy)
                        .padding(12)
                        .padding(.horizontal)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
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
                    }.foregroundStyle(Color.white)
                        .fontWeight(.heavy)
                        .padding(12)
                        .padding(.horizontal)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }

            }.padding()
        }
    }
}
