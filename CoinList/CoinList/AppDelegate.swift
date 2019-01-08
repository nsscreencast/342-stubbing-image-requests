//
//  AppDelegate.swift
//  CoinList
//
//  Created by Ben Scheirman on 2/23/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard !isRunningUnitTests else {
            window = nil
            return true
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    private var isRunningUnitTests: Bool {
        let env = ProcessInfo.processInfo.environment
        return env.keys.contains("XCInjectBundleInto")
    }
}

