//
//  RouterEmbedNaviVCOptions.swift
//  HHIndicationDemo
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHModule

public class RouterEmbedNaviVCOptions: ARCHRouterOptions {

    public func proccess(transition: ARCHTransition, animated: Bool) -> ARCHTransition {
        guard let toVC = transition.to as? UIViewController else {
            return transition
        }

        let naviVC = UINavigationController(rootViewController: toVC)
        return (transition.from, naviVC)
    }
}
