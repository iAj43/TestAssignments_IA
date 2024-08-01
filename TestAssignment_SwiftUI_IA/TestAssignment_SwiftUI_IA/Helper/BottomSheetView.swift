//
//  BottomSheetView.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import SwiftUI

struct BottomSheetView: View {
    
    @Binding var selection: Int
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Group {
                if let listData = homeViewModel.viewModelPublishers.mealTypesDetailData?[selection].listData as? [ListData] {
                    let titles = listData.map { $0.title ?? "" }
                    let dict = homeViewModel.topThreeCharacters(in: titles)
                    ScrollView {
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(header:
                                Text("Starters (\(listData.count) items)")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.black)
                                .padding(.vertical, 7)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.white)
                            ) {
                                ForEach(dict, id: \.self) { model in
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("\(model.character) = \(model.count)")
                                            .font(.callout)
                                            .foregroundColor(Color(.darkGray))
                                            .textCase(.uppercase)
                                            .padding(.bottom, 5)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.leading, .trailing], 25)
                                }
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color(.white))
                            }
                        }
                            
                        Button {
                            homeViewModel.viewModelPublishers.showBottomSheet = false
                        } label: {
                            Text("Done")
                                .font(.callout)
                                .bold()
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 40)
                                .foregroundColor(.white)
                                .background(Color(.themeButtonColor))
                                .cornerRadius(5)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color(.white))
                    }
                    .listStyle(.plain)
                    .background(.white)
                }
            }
        }
    }
}
