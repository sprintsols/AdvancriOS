//
//  AppDelegate.swift
//  Advancr
//
//  Created by Zain Ali on 02/04/2020.
//  Copyright © 2020 Zain Ali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

