//
//  AppDelegate.swift
//  architectureTeamA
//
//  Created by basalaev on 10.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit
import HHModule
import InfoManager

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

class CustomARCHWindow: ARCHWindow, InfoManagerDelegate {

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let rootController = self.rootViewController else {
            return
        }

        let vc = rootController.navigationController?.topViewController ?? rootController

        if motion == UIEvent.EventSubtype.motionShake {
            let infoManager = InfoManager()
            infoManager.delegate = self
            infoManager.presentValues(from: vc)
        }
    }

    // MARK: InfoManagerDelegate

    var values: [(key: String, value: String)] {
        return [
            (key: "userId", value: "1234567890"),
            (key: "authToken", value: "\(UUID().uuidString) \(UUID().uuidString) \(UUID().uuidString)"),
            (key: "fbsToken", value: UUID().uuidString),
            (key: "authToken", value: UUID().uuidString),
            (key: "authToken", value: UUID().uuidString),
            (key: "authToken", value: UUID().uuidString),
            (key: "authToken", value: UUID().uuidString),
            (key: "authToken", value: UUID().uuidString),
            (key: "authToken", value: UUID().uuidString),
            (key: "authToken", value: UUID().uuidString),
            (key: "authToken", value: UUID().uuidString)
        ]
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
