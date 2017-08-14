//
//  AppDelegate.swift
//  iMeiZi
//
//  Created by kingcos on 13/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Setup Fabric
        Fabric.with([Crashlytics.self])
        Fabric.with([Answers.self])

        return true
    }
    
}

