//
//  AppDelegate.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 14.12.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
//        UITabBar.appearance().barTintColor = Colors.success500.color
//        UITabBar.appearance().tintColor = Colors.danger500.color
//        UITabBar.appearance().layer.borderWidth = 1
//        UITabBar.appearance().layer.borderColor = Colors.gray200.color.cgColor
        UITabBar.appearance().backgroundColor = .gray100

//        UINavigationBar.appearance().barTintColor = .red
        UINavigationBar.appearance().tintColor = .accent

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: Fonts.headline17.font
        ]
//        if let navigationBar = self.navigationController?.navigationBar {
//            let titleFont = UIFont(name: "YourFontName", size: 17.0) // Replace "YourFontName" with the name of your desired font
//            
//            navigationBar.titleTextAttributes = [
//                NSAttributedString.Key.foregroundColor: UIColor.white,
//                NSAttributedString.Key.font: titleFont ?? UIFont.boldSystemFont(ofSize: 17.0)
//            ]
//        }
        
//        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

