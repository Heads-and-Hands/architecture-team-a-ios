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

    static func find(where block: ((ModuleInput) -> Bool)?) -> ARCHRouter?
}

public extension ARCHModuleConfigurator {

    static var moduleID: String {
        return "\(type(of: Self.self))"
    }

    static func find(where block: ((ModuleInput) -> Bool)?) -> ARCHRouter? {
        if let router = UIViewController() as? ARCHRouter {
            if router.moduleID == Self.moduleID {
                return router
            }
        }
        return nil
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
}
