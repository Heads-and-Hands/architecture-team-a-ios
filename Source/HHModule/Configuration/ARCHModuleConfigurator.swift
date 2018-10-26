//
//  ARCHModuleConfigurator.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

public protocol ARCHModuleConfigurator: class {

    associatedtype ModuleInput

    associatedtype ModuleOutput

    typealias ModuleIO = (ModuleInput) -> ModuleOutput

    static var moduleID: String { get }

    static func configure(moduleIO: ModuleIO?) -> ARCHRouter
}

public extension ARCHModuleConfigurator {

    static var moduleID: String {
        return "\(type(of: Self.self))"
    }
}

public extension ARCHModuleConfigurator {

    static func push(from: ARCHRouter?, animated: Bool) {
        let router = Self.configure(moduleIO: nil)
        router.transit(from: from,
                       options: [ARCHRouterPushOptions()],
                       animated: animated)
    }

    static func present(from: ARCHRouter?, animated: Bool) {
        let router = Self.configure(moduleIO: nil)
        router.transit(from: from,
                       options: [ARCHRouterPresentOptions()],
                       animated: animated)
    }

    static func displayOn(window: UIWindow?, animated: Bool) {
        let router = Self.configure(moduleIO: nil)
        router.transit(from: window,
                       options: [ARCHRouterWindowOptions()],
                       animated: animated)
    }

    static func drop(where block: ((ModuleInput) -> Bool)?) {
        if let viewController = Self.find(where: block) as? UIViewController {
            viewController.dismiss(animated: false, completion: nil)
        }
    }

    static func find(where block: ((ModuleInput) -> Bool)?) -> ARCHRouter? {
        guard let window = UIApplication.shared.delegate?.window else {
            return nil
        }

        var topViewController = window?.rootViewController

        if let navigationController = topViewController?.navigationController {
            topViewController = navigationController.topViewController
        }

        while let controller = topViewController {
            if let router = Self.check(viewController: controller, with: block) {
                return router
            }

            if let nc = controller as? UINavigationController {
                topViewController = nc.topViewController
            } else {
                topViewController = controller.presentedViewController
            }
        }
        return nil
    }

    static func check(viewController: UIViewController, with block: ((ModuleInput) -> Bool)?) -> ARCHRouter?  {
        if let router = viewController as? ARCHRouter,
            router.moduleID == Self.moduleID {
            if let block = block {
                if let input = router.moduleInput as? ModuleInput, block(input) {
                    return router
                }
                return nil
            }
            return router
        }
        return nil
    }
}
