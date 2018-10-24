//
//  ARCHModuleID.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

public protocol ARCHModuleID {
    var rawValue: String { get }
    var moduleID: String { get }

    var configurator: ARCHModuleConfigurator { get }
}

public extension ARCHModuleID {

    var rawValue: String {
        let string = String(describing: self)

        if let index = string.range(of: "(")?.lowerBound {
            return String(string[..<index])
        }

        return string
    }

    var moduleID: String {
        return "\(type(of: self))" + rawValue
    }
}

public extension ARCHModuleID {

    func push(from: ARCHRouter?, animated: Bool) {
        configurator.router.transit(from: from,
                                    options: [ARCHRouterPushOptions()],
                                    animated: animated)
    }

    func present(from: ARCHRouter?, animated: Bool) {
        configurator.router.transit(from: from,
                                    options: [ARCHRouterPresentOptions()],
                                    animated: animated)
    }

    func displayOn(window: UIWindow?, animated: Bool) {
        configurator.router.transit(from: window,
                                    options: [ARCHRouterWindowOptions()],
                                    animated: animated)
    }
}
