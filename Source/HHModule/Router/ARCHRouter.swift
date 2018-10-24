//
//  ARCHTransitionHandler.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

public typealias ARCHTransition = (from: AnyObject?, to: AnyObject)

public protocol ARCHRouterOptions {
    func proccess(transition: ARCHTransition, animated: Bool) -> ARCHTransition
}

public protocol ARCHRouter: class {
    func transit(from: ARCHRouter?, options: [ARCHRouterOptions], animated: Bool)
}

public extension ARCHRouter {

    func transit(from: ARCHRouter?, options: [ARCHRouterOptions], animated: Bool) {
        let transition = (from as AnyObject?, self as AnyObject)
        _ = options.reduce(transition) { $1.proccess(transition: $0, animated: animated) }
    }
}
