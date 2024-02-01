//
//  WalmartPlusView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/30/24.
//

import SwiftUI

struct WalmartPlusView: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("Save with")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.blue)
            Image("walmartpluslogo")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
        }
    }
}

#Preview {
    WalmartPlusView()
}
