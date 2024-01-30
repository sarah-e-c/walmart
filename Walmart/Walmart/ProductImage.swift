//
//  ProductImage.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct ProductImage: View {
    let product: Product
    var body: some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: URL(string: product.thumbnail)) { $0
                .resizable()
                .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150)
            .accessibilityLabel("Image of" + product.title)
            
            HeartButton()
        }.padding(.trailing, 5)
    }
}


private struct HeartButton: View {
    @State private var isFavorited = false
    var body: some View {
        Button {
            isFavorited.toggle()
        } label: {
            HStack(alignment: .top) {
                VStack(alignment: .trailing) {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .foregroundStyle(isFavorited ? Color.red : Color.primary)
                        .fontWeight(.light)
                        .padding(8)
                        .background()
                        .clipShape(Circle())
                }
            }
        }.offset(x: 120, y: -15)
    }
}


#Preview {
    ProductImage(product: Product.example)
}
