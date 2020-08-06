//
//  AppDelegate.swift
//  Example
//
//  Created by Md. Siam Biswas on 31/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import UIKit
import Engine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var coordinator:Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = RootCoordinator(window: UIWindow()).start()
        return true
    }
    

}

