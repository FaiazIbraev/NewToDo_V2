//
//  AppDelegate.swift
//  ToDoApp_v2
//
//  Created by Faiaz Ibraev on 20/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        navController = UINavigationController(rootViewController: MainViewController())
        
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        return true
    }
    
}

