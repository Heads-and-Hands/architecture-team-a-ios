//
//  AppDelegate.swift
//  architectureTeamA
//
//  Created by basalaev on 10.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit
import HHModule

#if HHNetwork || HHPaginationDemo
import HHNetwork
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

    var window: UIWindow? = UIWindow()
    var authBufferedController: UIViewController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchOptions?
        ) -> Bool {

        launchOn(window: window)

        return true
    }

    private func launchOn(window: UIWindow?) {
        ModulesUserStory.main { moduleInput in
            moduleInput.someValue = 1_234
//            moduleInput.set(moduleOutput: <#T##ARCHModuleOutput#>)
        }.displayOn(window: window, animated: false)
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

#if HHNetwork || HHPaginationDemo
extension AppDelegate: ARCHAuthObserverMoyaPluginDelegate {

    func didExpiredAuthToken() {
        print("[AppDelegate] >> didExpiredAuthToken")

        authBufferedController = window?.rootViewController
        // Делаем переход на экран авторизации
    }
}

extension AppDelegate: ARCHSignMoyaPluginDelegate {

    var signHeaderFields: [String: String] {
        if let token = Dependency.shared.userStorage.token?.value {
            return ["X-Auth-Token": token]
        } else {
            return [:]
        }
    }
}

extension AppDelegate: ARCHUserStorageDelegate {

    func didUpdateUser(from: ARCHUser?, to: ARCHUser?) {
        // TODO: Обновляем стек
    }
}
#endif
