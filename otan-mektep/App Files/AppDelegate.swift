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
//        if let user = Auth.auth().currentUser {
//
////        Auth.auth().addStateDidChangeListener { (auth, user) in
//                print("User is signed in with UID: \(user.uid)")
//                let mainViewController = self.instantiateMainViewController()
//                self.setRootViewController(mainViewController)
//            } else {
//                print("No user is signed in")
//                let loginViewController = self.instantiateLoginViewController()
//                self.setRootViewController(loginViewController)
//            
//        }
        /*
         Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // User is signed in
                // Navigate to the main content of your app
            } else {
                // No user is signed in
                // Present the login/signup view controller
            }
        }
        
        if Auth.auth().currentUser != nil {
            // User is signed in
            let mainViewController = instantiateMainViewController()

            // Set the main content view controller
            setRootViewController(mainViewController)
//            setRootTabBarController(mainViewController)

        } else {
            // No user is signed in
            let loginViewController = instantiateLoginViewController()

            // Set the login/signup view controller
            setRootViewController(loginViewController)

        }
        */
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


    func instantiateLoginViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    }

    func instantiateMainViewController() -> UIViewController {
        // Your logic to determine the user's role and instantiate the appropriate main view controller
        // For example, if the role is a pupil, instantiate the PupilTabBarController from PupilTabBar.storyboard

//
//        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "PupilTabBarController") as? UITabBarController {
//            return tabBarController
//        }
//        
//        return UIViewController()
        
        let storyboard = UIStoryboard(name: "PupilDiningTabBar", bundle: nil)

//        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "PupilTabBarController") as? UITabBarController {
//            return tabBarController
//        } else {
//            print("Failed to instantiate PupilTabBarController")
//            return UIViewController()
//        }
        
        

        if let navigationController = storyboard.instantiateViewController(withIdentifier: "PupilDiningNavigationController") as? UINavigationController {
            return navigationController
        } else {
            print("Failed to instantiate PupilTabBarController")
            return UIViewController()
        }

    }

    func setRootViewController(_ viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        print("Root view controller set to: \(viewController)")
    }
}

