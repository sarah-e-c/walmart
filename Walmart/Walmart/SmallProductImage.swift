//
//  ProductImage.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct SmallProductImage: View {
    let product: Product
    let vm: FavoriteViewModel
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                AsyncImage(url: URL(string: product.thumbnail)) { $0
                    .resizable()
                    .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Spacer()
            }

            .frame(width: 150, height: 150)
            .accessibilityLabel("Image of" + product.title)

            HeartButton(product: product, vm: vm)
        }
    }
}



#Preview {
    SmallProductImage(product: Product.example, vm: FavoriteViewModel())
}
