//
//  ARCHViewController.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

open class ARCHViewController<S: ARCHState, Out: ACRHViewOutput>: UIViewController, ARCHRouter, ARCHViewRenderable {

    public typealias State = S

    public var output: Out?

    open var childViews: [ARCHViewInput] {
        return []
    }

    open func render(state: State) {
        let mirror = Mirror(reflecting: state)
        for (_, childState) in mirror.children {
            childViews.forEach({ $0.update(state: childState) })
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        output?.viewIsReady()
    }
}
