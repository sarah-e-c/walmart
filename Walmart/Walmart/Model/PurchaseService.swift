//
//  PurchaseeService.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import Foundation


class PurchaseService {
    static var shared = PurchaseService()
    private let purchasedKey = "purchased"
    
    func loadPurchases() -> [Purchase] {
        guard let data = UserDefaults.standard.data(forKey: purchasedKey) else {
            print("No data saved.")
            return []
        }
        
        guard let purchased = try? JSONDecoder().decode([Purchase].self, from: data) else {
            print("Data failed to load.")
            return []
        }
        return purchased
    }
    
    func savePurchases(purchases: [Purchase]) {
        guard let data = try? JSONEncoder().encode(purchases) else {
            print("Cannot encode data.")
            return
        }
        
        UserDefaults.standard.setValue(data, forKey: purchasedKey)
        print("successfully set favorites!")
    }
    
    
    
}
