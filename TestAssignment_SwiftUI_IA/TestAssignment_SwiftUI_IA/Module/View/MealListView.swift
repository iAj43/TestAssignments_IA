//
//  MealListView.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import SwiftUI

struct MealListView: View {
    
    @Binding var selection: Int
    @Binding var searchText: String
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            ForEach(homeViewModel.viewModelPublishers.filteredList, id: \.self) { item in
                VStack {
                    HStack {
                        Image(item.image ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 76, height: 76)
                            .cornerRadius(5)
                            .clipped()
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.title ?? "")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 5)
                            Text(item.subtitle ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(Color(UIColor.darkGray))
                                .padding(.leading, 5)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .trailing], 10)
                    .padding([.top, .bottom], 8)
                    .listRowInsets(EdgeInsets())
                }
                .background(Color(UIColor.white))
                .cornerRadius(10)
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 4)
                .shadow(color: Color(UIColor.lightGray.withAlphaComponent(0.3)), radius: 5, x: 1, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)), lineWidth: 1)
                        .padding([.leading, .trailing], 20)
                        .padding([.top, .bottom], 4)
                )
            }
        }
        .onAppear {
            homeViewModel.filterListData()
        }
        .onChange(of: searchText) { _ in
            homeViewModel.filterListData()
        }
        .onChange(of: selection) { _ in
            homeViewModel.filterListData()
            searchText = ""
        }
        .listRowInsets(EdgeInsets())
    }
}

