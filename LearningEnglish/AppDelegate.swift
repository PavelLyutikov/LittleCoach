//
//  AppDelegate.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 28.12.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startViewController()
        
        FirebaseApp.configure()
        
        return true
    }
    
    func startViewController() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            saveArray()
            window?.rootViewController = PreloadMenuViewController()
       } else {
           window?.rootViewController = PreloadMenuViewController()
       }
       UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        
    }
    
    func saveArray() {
        let array: [String] = []
        
        UserDefaults.standard.set(array, forKey: "saveArrayWord")
    }
    
}

