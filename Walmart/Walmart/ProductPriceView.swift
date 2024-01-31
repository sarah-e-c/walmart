//
//  ProductPriceView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct ProductPriceView: View {
    let product: Product
    var body: some View {
        Group {
            if product.discountPercentage > 0 {
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    Text("Now $" + String(format: "%.2f", product.calculateDiscountedPrice()))
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.discountgreen)
                    Text("$\(product.price).00")
                        .strikethrough()
                        .font(.caption)
                        .fontWeight(.light)
                        .opacity(0.6)
                    Spacer()
                }
            } else {
                HStack(alignment: .bottom) {
                    Text("$\(product.price)")
                    Spacer()
                }
            }
        }.padding(.bottom, 4)
    }
}

#Preview {
    ProductPriceView(product: Product.example)
}
