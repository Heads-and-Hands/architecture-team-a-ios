//
//  CustomAnimationAppDelegate.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    typealias LaunchOptions = [UIApplicationLaunchOptionsKey: Any]

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool {

        let window = ARCHWindow()
        self.window = window
        launchOn(window: window)

        return true
    }

    private func launchOn(window: ARCHWindow) {
        ModulesCustomAnimationStory.main.displayEmbedInNavOn(window: window, animated: false)
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
}
