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
        var viewMirrors: [Mirror] = []

        var mirror: Mirror = Mirror(reflecting: self)

        viewMirrors.append(mirror)

        while let superclassMirror = mirror.superclassMirror,
            String(describing: mirror.subjectType) != String(describing: UIViewController.self) {
                viewMirrors.append(superclassMirror)
                mirror = superclassMirror
        }

        let stateMirror = Mirror(reflecting: state)

        viewMirrors.forEach({ viewMirror in

            for (_, viewProperty) in viewMirror.children {
                guard let view = viewProperty as? ARCHViewInput else {
                    continue
                }

                if self.autorenderIgnoreViews.contains(where: { $0 === view }) {
                    continue
                }

                self.render(state: stateMirror, on: view)
            }
        })
    }

    open func render(state: Mirror, on view: ARCHViewInput) {

        var currentState = state
        var states: [Mirror] = [state]

        while let superclassState = currentState.superclassMirror {
            states.append(superclassState)
            currentState = superclassState
        }

        states.forEach({ state in
            for (_, value) in state.children {
                if view.typeExist(state: value) {
                    view.update(state: value)
                    return
                }
            }
        })
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        prepareRootView()
        output?.viewIsReady()
    }

    open func prepareRootView() {
    }
}
