//
//  HomeView.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    MealTypeHeaderView(selection: $homeViewModel.viewModelPublishers.selection, homeViewModel: homeViewModel)
                        .listRowInsets(EdgeInsets())
                    Section(header: CustomSearchBar(searchText: $homeViewModel.viewModelPublishers.searchText)) {
                        MealListView(selection: $homeViewModel.viewModelPublishers.selection, searchText: $homeViewModel.viewModelPublishers.searchText, homeViewModel: homeViewModel)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .padding(.top, -50)
            .alert(isPresented: $homeViewModel.viewModelPublishers.showAlert, content: {
                Alert(title: Text("Failed"), message: Text(homeViewModel.viewModelPublishers.errorMessage), dismissButton: .default(Text("OK")))
            })
            .onAppear {
                homeViewModel.getMealData()
            }
            FloatingButtonView(showBottomSheet: $homeViewModel.viewModelPublishers.showBottomSheet)
        }
        .padding(.bottom, 20)
        .sheet(isPresented: $homeViewModel.viewModelPublishers.showBottomSheet) {
            if #available(iOS 16.0, *) {
                BottomSheetView(selection: $homeViewModel.viewModelPublishers.selection, homeViewModel: homeViewModel)
                    .presentationDetents([.height(250)])
            } else {
                // Fallback on earlier versions
                BottomSheetView(selection: $homeViewModel.viewModelPublishers.selection, homeViewModel: homeViewModel)
            }
        }
    }
}

#Preview {
    HomeView()
}

