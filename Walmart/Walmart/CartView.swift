//
//  CartView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var vm: CartViewModel
    @State private var isSheetPresented = false
    var body: some View {
        Button {
            isSheetPresented.toggle()
        } label: {
            HStack {
                
                VStack(spacing: 0) {
                    ZStack {
                        Image(systemName: "cart")
                            .foregroundStyle(Color.white)
                            .font(.title2)
                        Text("\(vm.cartSize)")
                            .bold()
                            .font(.caption)
                            .foregroundStyle(Color.black)
                            .padding(6)
                            .background(Circle()
                                .strokeBorder()
                                .foregroundStyle(Color.black).background(Color.yellow).clipShape(Circle()))
                            .offset(CGSize(width: 10.0, height: -10.0))
                    }
                    Text("$" + String(format: "%.2f", vm.cartPrice))
                        .foregroundStyle(Color.white)
                        .font(.caption)
                        .lineLimit(1)
                }
            }
        }.accessibilityHint("Opens a sheet to checkout.")
            
            .sheet(isPresented: $isSheetPresented, content: {
                CheckoutView(vm: vm)
            })
    }
}

#Preview {
    CartView(vm: CartViewModel())
}
