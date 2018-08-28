//
//  ARCHIndicationView.swift
//  HHSkeletonDemo
//
//  Created by basalaev on 28.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHModule

open class ARCHIndicationHelper<T: ARCHIndicationState>: ARCHViewRenderable {
    public typealias State = T

    public weak var container: ARCHIndicationContainer?

    public var providers: [ARCHIndicationTypes: ARCHIndicationViewProvider] = [:]
    private var currentView: ARCHIndicationView?

    public init() {}

    public func set(visible: Bool) {
        if !visible, let container = container {
            // TODO: Анимация
            currentView?.removeFrom(container: container.contextView)
        }
    }

    public func render(state: State) {
        guard let container = container else {
            return
        }

        // TODO: Добавить аниматор

        currentView?.removeFrom(container: container.contextView)

        guard let provider = providerBy(type: state.type) else {
            return
        }

        let view = provider.viewBy(state: state)
        view.update(state: state)
        view.showIn(container: container.contextView,
                    layoutGuide: container.layoutIndicationGuide,
                    animated: true)

        currentView = view
    }

    private func providerBy(type: ARCHIndicationTypes) -> ARCHIndicationViewProvider? {
        if let key = providers.keys.first(where: { $0.contains(type) }) {
            return providers[key]
        } else {
            return nil
        }
    }
}
