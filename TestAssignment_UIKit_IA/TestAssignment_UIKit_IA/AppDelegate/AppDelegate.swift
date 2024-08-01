//
//  AppDelegate.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - window
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupRootViewController()
        setupNavigationBarAppearance()
        return true
    }
    
    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: HomeController()) // set here rootViewController
    }
    
    func setupNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = .themeBackgroundColor
        UINavigationBar.appearance().tintColor = .themeBackgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = true
    }
}

