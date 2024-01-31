//
//  SearchView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var vm: SearchViewModel
    @State private var currentText = ""
    var body: some View {
        VStack {
            ToolBarView(currentText: $currentText, vm: vm)
                .padding(.bottom, -8)
            if vm.errorMessage != "" {
                Text(vm.errorMessage)
            } else if vm.lastSearchTerm == "" {
                EnterSearchView()
            } else if vm.numProducts == 0 {
                ResultsNotFoundView()
            } else {
                ScrollView {
                    // result summary text
                    VStack(alignment: .leading) {
                        HStack(alignment: .lastTextBaseline) {
                            Text("Results for \"" + vm.lastSearchTerm + "\"")
                                .font(.title3)
                                .bold()
                            Text("(\(vm.numProducts))")
                                .font(.caption)
                                .opacity(0.7)
                            Spacer()
                        }
                        Text("Price when purchased online  ⓘ")
                            .font(.caption)
                    }.padding()

                    // products
                    VStack {
                        ForEach(vm.products) { product in
                            SearchProductView(product: product, vm: vm)
                            Divider()
                        }
                        Spacer()
                    }
                }

            }
            
        }.preferredColorScheme(.light)
    }
}

struct ToolBarView: View {
    @Binding var currentText: String
    @ObservedObject var vm: SearchViewModel
    var body: some View {
        VStack {
            // top elements of toolbar
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.white)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, 4)

                // search bar itself
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 4)
                    TextField(text: $currentText) {
                        Text("Search Walmart")
                    }.onSubmit {
                        Task {
                            await vm.getProducts(searchTerm: currentText)
                        }
                    }
                    .font(.callout)
                    .opacity(0.7)
                    Spacer()
                    Image(systemName: "barcode.viewfinder")
                        .font(.title2)
                        .padding(.vertical, -4)
                        
                }.padding(10).background(Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                Spacer()

                CartView(vm:vm.cartViewModel)

            }.padding()
            HStack {
                Image(decorative: "phonehandimage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 27)
                Text("How do you want your items? | 95829")
                    .opacity(0.9)
                    .font(.headline)
                    .fontWeight(.light)
                Spacer()
                Image(systemName: "chevron.down")
            }
            .padding(.horizontal)
            .padding(.bottom, 8).foregroundStyle(Color.white)
        }.background(Color.blue)
    }
}

private struct EnterSearchView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Enter your search above for exclusive deals!")
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding()
                .accessibility(hidden: true)
            Spacer()
        }.padding()
    }
}

private struct ResultsNotFoundView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No results were found. Please try again.")
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
        }.padding()
    }
}


#Preview {
    SearchView(vm: SearchViewModel(cartViewModel: CartViewModel(), favoriteViewModel: FavoriteViewModel()))
}


