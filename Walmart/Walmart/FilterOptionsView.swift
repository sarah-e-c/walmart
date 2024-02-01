//
//  FilterOptoinsView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/31/24.
//

import SwiftUI

struct FilterOptionsView: View {
    @ObservedObject var vm: SearchViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        List {
            Section("Price Range") {
                HStack {
                    Text("From")
                    Spacer()
                    TextField("Start Price", value: $vm.startPrice, format: .currency(code: "USD"))
                        .multilineTextAlignment(.trailing)
                }

                HStack {
                    Text("To")
                    Spacer()
                    TextField("End Price", value: $vm.endPrice, format: .currency(code: "USD"))
                        .multilineTextAlignment(.trailing)
                }
            }
            Section("Sort By") {
                Picker("Sorted by", selection: $vm.sortingKey) {
                    ForEach(SortingOptionKey.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
            }
            Button {
                dismiss()
            } label: {
                Text("Search products")
            }
        }
    }
}

#Preview {
    FilterOptionsView(vm: SearchViewModel())
}
