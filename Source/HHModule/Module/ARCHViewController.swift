//
//  ARCHViewController.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

open class ARCHViewController<State: ARCHState, ViewOutput: ACRHViewOutput>: UIViewController, ARCHModule, ARCHRouter, ARCHViewRenderable {
    public typealias ViewState = State

    public var output: ViewOutput?

    private var moduleIsReady: Bool = false

    open var autorenderIgnoreViews: [ARCHViewInput] {
        return []
    }

    private let debugLog: ((String) -> Void)? = {
        if let debugMode = ProcessInfo.processInfo.environment["ARCHViewControllerDebugMode"], Int(debugMode) == 1 {
            return { print("[\(Thread.isMainThread ? "Main" : "Back")][ARCHViewController] " + $0) }
        } else {
            return nil
        }
    }()

    open func insert(to module: ARCHRouter, container: UIView, animated: Bool) {
        guard let vc = module as? UIViewController else {
            return
        }
        vc.addChild(self)

        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: container.topAnchor),
            view.leftAnchor.constraint(equalTo: container.leftAnchor),
            view.rightAnchor.constraint(equalTo: container.rightAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        didMove(toParent: self)
    }

    open func render(state: ViewState) {
        debugLog?("begin render state")

        var views = autorenderViews
        debugLog?("Autorender views:")
        views.forEach({ debugLog?("\(type(of: $0))") })

        let substates = self.substates(state: state)
        debugLog?("Autorender states:")
        substates.forEach({ debugLog?("\(type(of: $0))") })

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

        debugLog?("end render state")
    }

    private func substates(state: ViewState) -> [Any] {
        return Mirror(reflecting: state).children.map { $0.value }
    }

    /**
     Извлекаем свойства для каждого наследника данного класса
     */
    private var autorenderViews: [ARCHViewInput] {
        var properies: [ARCHViewInput] = []
        let parentType = String(describing: ARCHViewController<State, ViewOutput>.self)
        var mirror = Mirror(reflecting: self)

        repeat {
            let currentProperties = mirror.children.compactMap { _, value -> ARCHViewInput? in
                guard let viewInput = value as? ARCHViewInput else {
                    debugLog?("Not supported \(type(of: value))")
                    return nil
                }

                if autorenderIgnoreViews.contains(where: { $0 === viewInput }) {
                    debugLog?("Ignored property \(type(of: value))")
                    return nil
                } else {
                    debugLog?("Add property \(type(of: value))")
                    return viewInput
                }
            }

            properies.append(contentsOf: currentProperties)

            if let superClassMirror = mirror.superclassMirror {
                mirror = superClassMirror
            } else {
                break
            }
        } while String(describing: mirror.subjectType) != parentType

        return properies
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open func prepareRootView() {
    }

    // MARK: - ARCHModule

    public var router: ARCHRouter {
        if !moduleIsReady {
            moduleIsReady = true
            prepareRootView()
            output?.viewIsReady()
        }
        return self
    }

    public var moduleInput: ARCHModuleInput? {
        return output as? ARCHModuleInput
    }

    public var moduleID: String?
}
