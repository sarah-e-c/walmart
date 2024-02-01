//
//  Purchase.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/31/24.
//

import Foundation


struct Purchase: Codable, Identifiable {
    var id = UUID()
    let products: [Product]
    let date: Date
}
