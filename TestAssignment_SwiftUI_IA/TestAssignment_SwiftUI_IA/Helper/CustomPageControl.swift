//
//  CustomPageControl.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import SwiftUI

struct CustomPageControl: View {
    let totalIndex: Int
    let selectedIndex: Int
    
    @Namespace private var animation
    
    var body: some View {
        HStack {
            ForEach(0..<totalIndex, id: \.self) { index in
                if selectedIndex == index {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .overlay {
                            Circle()
                                .fill(Color(UIColor(red: 0.17, green: 0.60, blue: 0.94, alpha: 1.00)))
                                .frame(width: 8, height: 8)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                                .matchedGeometryEffect(id: "IndicatorAnimationId", in: animation)
                        }
                } else {
                    Circle()
                        .fill(Color(.gray))
                        .frame(width: 8, height: 8)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
            }
        }
        .frame(width: CGFloat(totalIndex)*30)
        .animation(.easeOut, value: selectedIndex)
    }
}
