//
//  CartViewModel.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//
import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cart: [Product: Int] = [:]
    @Published var cartSize: Int = 0
    @Published var cartPrice: Double = 0
    @Published var cartUndiscountedPrice: Int = 0
    @Published var cartItems: [Product] = []
    
    //positive for easy viewing
    var positiveCartDiscount: Double { Double(cartUndiscountedPrice) - cartPrice  }
    
    var favoriteViewModel: FavoriteViewModel?
    
    init() {
        self.favoriteViewModel = nil
    }
    
    init(favoriteViewModel: FavoriteViewModel) {
        self.favoriteViewModel = favoriteViewModel
    }
    
    func getProductQuantity(product: Product) -> Int {
        return cart[product] ?? 0
    }
    
    func addToCart(product: Product) {
        if cart[product] != nil && cart[product] != 0 {
            cart[product]! += 1
        } else {
            cart[product] = 1
            cartItems.append(product)
        }
        
        cartSize += 1
        cartPrice += product.calculateDiscountedPrice()
        cartUndiscountedPrice += product.price
    }
    
    func removeFromCart(product: Product) {
        guard cart[product] != nil && cart[product] != 0 else {
            return
        }
        
        cart[product]! -= 1
        cartSize -= 1
        if cart[product] == 0 { cartItems.remove(at: cartItems.firstIndex(of: product)!) }
        
        cartPrice -= product.calculateDiscountedPrice()
        cartUndiscountedPrice -= product.price
        
        if cartPrice < 0 { cartPrice = 0 }
        if cartUndiscountedPrice < 0 { cartUndiscountedPrice = 0 }
    }
    
    func checkoutItems() {
        cart = [:]
        cartSize = 0
        cartPrice = 0
        cartUndiscountedPrice = 0
        cartItems = []
    }
}
