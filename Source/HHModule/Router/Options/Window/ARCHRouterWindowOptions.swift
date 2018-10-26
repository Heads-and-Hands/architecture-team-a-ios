//
//  ARCHRouterWindowOptions.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHRouterWindowOptions: ARCHRouterOptions {

    private let options: ARCHWindowTransitionOptions

    public init(options: ARCHWindowTransitionOptions = ARCHWindowTransitionOptions()) {
        self.options = options
    }

    public func proccess(transition: ARCHTransition, animated: Bool) -> ARCHTransition {
        if let from = transition.from as? UIWindow, let to = transition.to as? UIViewController {
            var backgroundWindow: TransitionWindow?
            if from.rootViewController != nil, animated {
                if let backgroundColor = options.backgroundColor {
                    backgroundWindow = TransitionWindow(frame: UIScreen.main.bounds)
                    backgroundWindow?.backgroundColor = backgroundColor
                    backgroundWindow?.makeKeyAndVisible()
                }

                let animation = options.animation
                animation.delegate = backgroundWindow
                from.layer.add(animation, forKey: kCATransition)
            }

            from.rootViewController = to
            from.makeKeyAndVisible()
        }

        return transition
    }
}

private class TransitionWindow: UIWindow, CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("\(animationDidStop)")

        DispatchQueue.main.async { [weak self] in
            self?.removeFromSuperview()
        }
    }
}
