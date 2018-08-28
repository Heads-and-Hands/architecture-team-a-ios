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

    open var autorenderIgnoreViews: [ARCHViewInput] {
        return []
    }

    open func render(state: State) {
        let viewMirror = Mirror(reflecting: self)
        let stateMirror = Mirror(reflecting: state)

        for (_, viewProperty) in viewMirror.children {
            guard let view = viewProperty as? ARCHViewInput else {
                continue
            }

            if autorenderIgnoreViews.contains(where: { $0 === view }) {
                continue
            }

            render(state: stateMirror, on: view)
        }
    }

    open func render(state: Mirror, on view: ARCHViewInput) {
        for (_, value) in state.children {
            if view.typeExist(state: value) {
                view.update(state: value)
                return
            }
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        prepareRootView()
        output?.viewIsReady()
    }

    open func prepareRootView() {
    }
}
