//
//  FloatingButtonView.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import SwiftUI

struct FloatingButtonView: View {
    
    @Binding var showBottomSheet: Bool
    
    var body: some View {
        VStack {
            Button {
                showBottomSheet.toggle()
            } label: {
                Image("ic_home_floating")
                    .padding()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .background(Color(.themeButtonColor))
            }
            .clipShape(Circle())
            .padding(.trailing, 20)
            .padding(.bottom, -10)
            .shadow(color: Color(UIColor.lightGray), radius: 5, x: 0, y: 2)
        }
    }
}
