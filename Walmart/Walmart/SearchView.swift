//
//  SearchView.swift
//  Walmart
//
//  Created by Sarah Crowder on 1/29/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var vm: SearchViewModel
    @ObservedObject var favoriteVM: FavoriteViewModel
    @ObservedObject var cartVM: CartViewModel
    @State private var currentText = ""
    var body: some View {
        VStack(spacing: 0) {
            ToolBarView(currentText: $currentText, vm: vm, cartVM: cartVM, favoriteVM: favoriteVM)
            ScrollView {
                HStack {
                    FilterButton(vm: vm, currentText: $currentText)
                    Spacer()
                }.padding([.horizontal, .top])
                if vm.errorMessage != "" {
                    Text(vm.errorMessage)
                } else if vm.lastSearchTerm == "" {
                    EnterSearchView()
                } else if vm.numProducts == 0 {
                    ResultsNotFoundView()
                } else {
                    // result summary text
                    VStack(alignment: .leading, spacing: UIConstants.medPadding) {
                        HStack(alignment: .lastTextBaseline) {
                            Text("Results for \"" + vm.lastSearchTerm + "\"")
                                .font(.title3)
                                .bold()
                            Text("(\(vm.numProducts))")
                                .font(.callout)
                                .opacity(0.7)
                            Spacer()
                        }
                        Text("Price when purchased online  ⓘ")
                            .font(.footnote)
                    }.padding()

                    // products
                    VStack {
                        ForEach(vm.products) { product in
                            SearchProductView(product: product, favoriteVM: favoriteVM, cartVM: cartVM)
                                .padding(.vertical, UIConstants.medPadding)
                            Divider()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

private struct FilterButton: View {
    @ObservedObject var vm: SearchViewModel
    @Binding var currentText: String
    @State private var isSheetPresented = false

    var body: some View {
        Button {
            isSheetPresented.toggle()
        } label: {
            HStack {
                Image(systemName: "line.3.horizontal.decrease")
                Text("Filter/Sort")
                    .fontWeight(.light)
            }
        }.foregroundStyle(vm.isFilterEnabled ? Color(UIColor.systemBackground) : Color.primary)
            .padding(UIConstants.largePadding)
            .background(vm.isFilterEnabled ? Color.blue : Color(UIColor.systemBackground), in: .rect(cornerRadius: UIConstants.largeCornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: UIConstants.largeCornerRadius).stroke(Color.primary, lineWidth: vm.isFilterEnabled ? 0.0 : 1.0)
            }
            .sheet(isPresented: $isSheetPresented) {
                FilterOptionsView(vm: vm)
                    .presentationDetents([.medium])
                // (there is a better way to do this I'm pretty sure)
            }.onChange(of: vm.sortingKey) {
                Task {
                    await vm.getProducts(searchTerm: currentText)
                }
            }.onChange(of: vm.startPrice) {
                Task {
                    await vm.getProducts(searchTerm: currentText)
                }
            }.onChange(of: vm.endPrice) {
                Task {
                    await vm.getProducts(searchTerm: currentText)
                }
            }
    }
}

private struct ToolBarView: View {
    @Binding var currentText: String
    @ObservedObject var vm: SearchViewModel
    @ObservedObject var cartVM: CartViewModel
    @ObservedObject var favoriteVM: FavoriteViewModel
    var body: some View {
        VStack {
            // top elements of toolbar
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.white)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, UIConstants.smallPadding)

                // search bar itself
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, UIConstants.smallPadding)
                    
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

                }.padding(UIConstants.medPadding).background(Color(UIColor.systemBackground), in: .rect(cornerRadius: UIConstants.largeCornerRadius))
                
                Spacer()

                CartView(vm: cartVM, favoriteVM: favoriteVM)

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
            .padding(.bottom, UIConstants.medPadding).foregroundStyle(Color.white)
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
    SearchView(vm: SearchViewModel(), favoriteVM: FavoriteViewModel(), cartVM: CartViewModel())
}
