//
//  TabLabel.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import SwiftUI

struct TabLabel: View {
    let imageName: String
    let tabLabel: String
    
    init(_ imageName: String, _ tabLabel: String) {
        self.imageName = imageName
        self.tabLabel = tabLabel
    }
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .environment(\.symbolVariants, .none)
                .fontWeight(.light)
                .padding(.bottom, 2)
                
            Text(tabLabel)
                .font(.caption)
                .fontWeight(.light)
        }
    }
}

#Preview {
    TabLabel( "heart", "My Items")
}
