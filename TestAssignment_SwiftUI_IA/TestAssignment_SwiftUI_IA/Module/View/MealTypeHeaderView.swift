//
//  MealTypeHeaderView.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import SwiftUI

struct MealTypeHeaderView: View {
    
    @Binding var selection: Int
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selection) {
                ForEach(0..<(homeViewModel.viewModelPublishers.mealTypesDetailData?.count ?? 0), id: \.self) { index in
                    if let imageName = homeViewModel.viewModelPublishers.mealTypesDetailData?[index].typeImage {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .tag(index)
                            .background(Color(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)))
                            .frame(height: 200)
                            .padding(.top, -20)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .frame(height: 270)
            .padding([.leading, .trailing], 20)
            .padding(.bottom, -15)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(homeViewModel.viewModelPublishers.mealTypesDetailData?[selection].typeTitle ?? "Home")
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .toolbarBackground(
                Color.white,
                for: .navigationBar
            )
            VStack {
                Spacer()
                CustomPageControl(totalIndex: (homeViewModel.viewModelPublishers.mealTypesDetailData?.count ?? 0), selectedIndex: selection)
                    .padding(.bottom, 7)
            }
        }
    }
}
