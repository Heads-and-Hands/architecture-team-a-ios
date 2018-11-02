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

    public var providers: [ARCHIndicationTypes: ARCHIndicationViewProvider] = [:]
    public var currentView: ARCHIndicationView?

    public init() {}

    public func set(provider: ARCHIndicationViewProvider, by key: ARCHIndicationTypes) {
        var buffer: [ARCHIndicationTypes: ARCHIndicationViewProvider] = [:]

        for (storedKey, value) in providers {
            var changedStoredKey = storedKey
            _ = changedStoredKey.remove(key)
            if changedStoredKey != [] {
                buffer[changedStoredKey] = value
            }
        }

        buffer[key] = provider
        providers = buffer
    }

    // MARK: - ARCHViewInput

    open func update(state: Any) -> Bool {
        guard let state = state as? T, let container = container else {
            return false
        }

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

    open func set(visible: Bool) {
        if !visible, let container = container {
            currentView?.removeFrom(container: container.contextView)
        }
    }

    open func providerBy(type: ARCHIndicationTypes) -> ARCHIndicationViewProvider? {
        if let key = providers.keys.first(where: { $0.contains(type) }) {
            return providers[key]
        } else {
            return nil
        }
    }
}
