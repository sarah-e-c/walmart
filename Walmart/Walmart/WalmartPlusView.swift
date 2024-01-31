//
//  WalmartPlusView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct WalmartPlusView: View {
    var body: some View {
        HStack {
            Text("Save with")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.blue)
                .padding(.trailing, -4)
            Image("walmartpluslogo")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
        }.padding(.bottom, 2)
    }
}


#Preview {
    WalmartPlusView()
}
