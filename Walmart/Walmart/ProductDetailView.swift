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
    @State private var carouselNumber = 0
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
                        // top row
                        VStack(alignment: .leading) {
                            Text(product.brand)
                                .font(.caption)
                                .underline()
                            Text(product.title)
                                .font(.title)
                                .fontWeight(.light)
                        }.padding()
                        Spacer()
                        ShareLink(item: "www.walmart.com", subject: Text(product.title),
                                  message: Text("Check out this awesome " + product.title + " from Walmart!"), preview: SharePreview(product.title, image: Image(systemName: "heart")))
                        {
                            Image(systemName: "square.and.arrow.up")
                                .renderingMode(.original)
                        }
                        .padding(.horizontal)
                    }
                    // image carousel

                    TabView(selection: $carouselNumber) {
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
                        .frame(height: 250).padding()

                    VStack(alignment: .leading) {
                        HStack {
                            ProductPriceView(product: product)
                            StarsView(product: product)
                        }
                        Text(product.description)
                            .padding(.bottom, 4)

//                        Text("Reviews")
//                            .font(.title2)
//                            .fontWeight(.light)
                    }.padding()
                }
                VStack {
                    Spacer()
                    AddToCartButton(vm: cartVM, product: product)
                }.padding()
            }
        }
    }
}

#Preview {
    ProductDetailView(product: Product.example, cartVM: CartViewModel())
}
