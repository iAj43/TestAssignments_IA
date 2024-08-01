//
//  CustomSearchBar.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import SwiftUI

struct CustomSearchBar: View {
    
    @State private var isEditing = false
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                        .padding(.leading, 10)
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text("Search")
                                .foregroundColor(Color(.darkGray))
                        }
                        TextField("Search", text: $searchText)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .padding([.top, .bottom], 5)
                            .foregroundColor(Color(.darkGray))
                            .onTapGesture {
                                self.isEditing = true
                            }
                    }
                }
                .background(Color(UIColor.white))
                .cornerRadius(10)
                
                if isEditing {
                    Button {
                        searchText = ""
                        self.isEditing = false
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color(UIColor.lightGray))
                    }
                }
            }
            .padding([.leading,.trailing], 30)
            .padding([.top,.bottom], 10)
        }
        .listRowInsets(EdgeInsets())
        .background(Color(UIColor.themeBackgroundColor))
    }
}
