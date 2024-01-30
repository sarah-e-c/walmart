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
            VStack {
                ZStack {
                    Image(systemName: "cart")
                        .foregroundStyle(Color.white)
                        .font(.title3)
                    Text("\(vm.cartSize)")
                        .bold()
                        .font(.caption)
                        .foregroundStyle(Color.black)
                        .padding(5)
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
        }.frame(width: 50)
            .sheet(isPresented: $isSheetPresented, content: {
                CheckoutView(vm: vm)
            })
    }
}


#Preview {
    CartView(vm: CartViewModel())
}
