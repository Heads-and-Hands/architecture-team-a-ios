//
//  ARCHRouterPresentOptions.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHRouterPresentOptions: ARCHRouterOptions {

    public func proccess(transition: Transition, animated: Bool) -> Transition {
        if let from = transition.from as? UIViewController, let to = transition.to as? UIViewController {
            from.present(to, animated: animated, completion: nil)
        }

        return transition
    }
}
