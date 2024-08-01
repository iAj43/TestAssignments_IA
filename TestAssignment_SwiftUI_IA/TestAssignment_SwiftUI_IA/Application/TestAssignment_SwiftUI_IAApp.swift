//
//  TestAssignment_SwiftUI_IAApp.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import SwiftUI

@main
struct TestAssignment_SwiftUI_IAApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .background(Color(UIColor.themeBackgroundColor))
            }
        }
    }
}
