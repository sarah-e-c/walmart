//
//  SortingOption.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/31/24.
//

import Foundation


enum SortingOptionKey: String, CaseIterable {
    case none = "No Sorting"
    case priceHighToLow = "Price: High to Low"
    case priceLowToHigh = "Price: Low to High"
    case ratingHighToLow = "Rating: High to Low"
    case ratingLowToHigh = "Rating: Low to High"
    case alphabetical = "Alphabetical"
}
