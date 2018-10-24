//
//  ARCHViewController.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

open class ARCHViewController<S: ARCHState, Out: ACRHViewOutput>: UIViewController, ARCHRouter, ARCHViewRenderable {

    public typealias ViewState = S

    public var output: Out?

    open var autorenderIgnoreViews: [ARCHViewInput] {
        return []
    }

    open func render(state: ViewState) {
        guard output?.shouldRender(state) ?? true else {
            return
        }

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

        let childStates = (substates.first(where: { $0 is [ARCHState] }) as? [ARCHState]) ?? []

        children.compactMap({ $0 as? ARCHViewInput }).forEach({ input in
            childStates.forEach({
                input.update(state: $0)
            })
        })

        print("[ARCHViewController] end render(state:)")
    }

    private func substates(state: ViewState) -> [Any] {
        return Mirror(reflecting: state).children.map { $0.value }
    }

    private var autorenderViews: [ARCHViewInput] {
        var mirrors: [Mirror] = []
        var mirror: Mirror = Mirror(reflecting: self)

        mirrors.append(mirror)

        while let superclassMirror = mirror.superclassMirror,
            String(describing: mirror.subjectType) != String(describing: UIViewController.self) {
                mirrors.append(superclassMirror)
                mirror = superclassMirror
        }

        let children = mirrors.reduce([], { (result: [Mirror.Child], mirror: Mirror) -> [Mirror.Child] in
            var result = result
            result.append(contentsOf: mirror.children)
            return result
        })

        return children
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
