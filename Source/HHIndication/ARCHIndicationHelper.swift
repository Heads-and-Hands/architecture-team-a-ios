//
//  ARCHIndicationView.swift
//  HHSkeletonDemo
//
//  Created by basalaev on 28.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHModule

open class ARCHIndicationHelper<T: ARCHIndicationState>: ARCHViewInput {

    public weak var container: ARCHIndicationContainer?

    private var providers: [ARCHIndicationTypes: ARCHIndicationViewProvider] = [:]
    private var currentView: ARCHIndicationView?

    public init() {}

    public func set(provider: ARCHIndicationViewProvider, by key: ARCHIndicationTypes) {
        var buffer: [ARCHIndicationTypes: ARCHIndicationViewProvider] = [:]

        for var (storedKey, value) in providers {
            _ = storedKey.remove(key)
            if storedKey != [] {
                buffer[storedKey] = value
            }
        }

        buffer[key] = provider
        providers = buffer

        print("buffer \(buffer)")
    }

    // MARK: - ARCHViewInput

    public var sortPriority: Int {
        return Int.max
    }

    public func update(state: Any) -> Bool {
        guard let state = state as? T, let container = container else {
            return false
        }

        // TODO: Добавить аниматор

        currentView?.removeFrom(container: container.contextView)

        guard let provider = providerBy(type: state.type) else {
            return false
        }

        let view = provider.viewBy(state: state)
        if view.update(state: state) {
            view.showIn(container: container.contextView,
                        layoutGuide: container.layoutIndicationGuide,
                        animated: true)
        }

        currentView = view

        return true
    }

    public func ignoredViews(by state: Any) -> [ARCHViewInput] {
        return currentView?.ignoredViews(by: state) ?? []
    }

    public func set(visible: Bool) {
        currentView?.set(visible: visible)
//        if !visible, let container = container {
//            // TODO: Анимация
//            currentView?.removeFrom(container: container.contextView)
//        }
    }

    // MARK: - Private

    private func providerBy(type: ARCHIndicationTypes) -> ARCHIndicationViewProvider? {
        if let key = providers.keys.first(where: { $0.contains(type) }) {
            return providers[key]
        } else {
            return nil
        }
    }
}
