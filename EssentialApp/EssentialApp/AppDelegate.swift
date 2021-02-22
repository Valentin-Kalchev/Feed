//
//  AppDelegate.swift
//  EssentialApp
//
//  Created by Valentin Kalchev (Zuant) on 18/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: UISceneSession Lifecycle
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("applicationDidFinishLaunching")
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
        #if DEBUG
        configuration.delegateClass = DebuggingSceneDelegate.self
        #else
        configuration.delegateClass = SceneDelegate.self
        #endif
        
        return configuration
    }
}

