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
        var views = autorenderViews
        let substates = self.substates(state: state)

        var index: Int = 0
        while index < views.count {
            let view = views[index]
            var isVisible = false

            for substate in substates where view.update(state: substate) {
                isVisible = true
                break
            }

            view.set(visible: isVisible)
            index += 1
        }

        print("[ARCHViewController] end render(state:)")
    }

    private func substates(state: State) -> [Any] {
        return Mirror(reflecting: state).children.map({ $0.value })
    }

    private var autorenderViews: [ARCHViewInput] {
        return Mirror(reflecting: self).children
            .compactMap({ item -> ARCHViewInput? in
                guard let value = item.value as? ARCHViewInput else {
                    return nil
                }

                if autorenderIgnoreViews.contains(where: { $0 === value }) {
                    return nil
                } else {
                    return value
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
