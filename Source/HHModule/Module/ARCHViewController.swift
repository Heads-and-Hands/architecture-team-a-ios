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
        print("[ARCHViewController] start render(state:)")

        var views = autorenderViews
        let substates = self.substates(state: state)

//        debugDisplay(states: substates)

        var index: Int = 0
        while index < views.count {
            let view = views[index]
            print("\(type(of: view))")
            var isVisible = false

            for substate in substates {
                if view.update(state: substate) {
                    let ignoredViews = view.ignoredViews(by: substate)
                    views = views.filter { item -> Bool in
                        ignoredViews.contains(where: { $0 === item })
                    }
                    isVisible = true
                    break
                }
            }

            print("isVisible \(isVisible)")

            view.set(visible: isVisible)
            index += 1
        }

        print("[ARCHViewController] end render(state:)")
    }

    private func debugDisplay(states: [Any]) {
        print("States >>>>>>>>>>>>>>>>>>>>>>>")
        states.forEach({ print("\(type(of: $0))")})
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
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
            .sorted(by: { $0.sortPriority > $1.sortPriority })
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        prepareRootView()
        output?.viewIsReady()
    }

    open func prepareRootView() {
    }
}
