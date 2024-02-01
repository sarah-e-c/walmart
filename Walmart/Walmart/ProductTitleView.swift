//
//  ProductTitleView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct ProductTitleView: View {
    let product: Product
    var body: some View {
        Text(product.title)
            .fontWeight(.light)
            .font(.callout)
    }
}
#Preview {
    ProductTitleView(product: Product.example)
}
