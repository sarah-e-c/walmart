//
//  StarsView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct StarsView: View {
    let product: Product
    func getStarImage(numStar: Int, rating: Double) -> String {
        // this function returns the system name of the appropriate
        // star image based on the rating of a product.
        // anything that is within .25 of a whole will be represented as
        // a full/empty star.
        if Double(numStar) <= rating {
            return "star.fill"
        } else if Double(numStar) - rating <= 0.25 {
            return "star.fill"
        } else if Double(numStar) - rating >= 0.75 {
            return "star"
        }
        return "star.leadinghalf.filled"
    }

    var body: some View {
        HStack {
            HStack(spacing: 0) {
                Image(systemName: getStarImage(numStar: 1, rating: product.rating))
                Image(systemName: getStarImage(numStar: 2, rating: product.rating))
                Image(systemName: getStarImage(numStar: 3, rating: product.rating))
                Image(systemName: getStarImage(numStar: 4, rating: product.rating))
                Image(systemName: getStarImage(numStar: 5, rating: product.rating))
            }.foregroundStyle(Color.yellow)

            Text(String(product.rating))
        }
        .font(.caption)
        .accessibilityHidden(true)
        .accessibilityLabel("Rated" + String(product.rating) + "out of 5 stars.")
    }
}

#Preview {
    StarsView(product: Product.example)
}
