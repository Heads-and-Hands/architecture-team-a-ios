//
//  AppDelegate.swift
//  architectureTeamA
//
//  Created by basalaev on 10.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit
import HHModule
import HHPreferences

#if HHNetwork || HHPaginationDemo
import HHNetwork
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

    var window: UIWindow?
    var authBufferedController: UIViewController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchOptions?
        ) -> Bool {

        let preferences: [Preference] = [
            Preference(name: "Release", value: "https://yandex.ru", type: .constant, isSelected: false),
            Preference(name: "Debug", value: "https://mail.ru", type: .constant, isSelected: true),
            Preference(name: "Custom", value: "", type: .custom, isSelected: false)
        ]

        PreferencesManager.shared.setPreferences(key: "NETWORK_BASE_PATH", preferences: preferences)

        let window = CustomARCHWindow()
        self.window = window

//        window.rootViewController = SkeletonTestViewController()
//        window.makeKeyAndVisible()
        launchOn(window: window)

        return true
    }

    private func launchOn(window: ARCHWindow) {
        ModulesUserStory.main.displayOn(window: window, animated: false)
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

class CustomARCHWindow: ARCHWindow {

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let rootController = self.rootViewController else {
            return
        }

        let vc = rootController.navigationController?.topViewController ?? rootController

        if motion == UIEvent.EventSubtype.motionShake {
            PreferencesManager.shared.presentPreferences(for: "NETWORK_BASE_PATH", in: vc)
        }
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
