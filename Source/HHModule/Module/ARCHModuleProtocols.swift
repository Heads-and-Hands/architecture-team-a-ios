//
//  ARCHModuleProtocols.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

/**
 Родительский протокол, описывающий состояние модуля
 */
public protocol ARCHState {
    init()
}

public protocol ARCHViewInput: class {
    func update(state: Any?)

    func set(visible: Bool)

    func typeExist(state: Any?) -> Bool
}

public extension ARCHViewInput where Self: UIView {

    func set(visible: Bool) {
        isHidden = visible
    }
}

public extension ARCHViewInput {

    func set(visible: Bool) {
    }
}

public protocol ARCHViewRenderable: ARCHViewInput {
    associatedtype State: Any
    func render(state: State)
}

public extension ARCHViewRenderable where State: Any {

    func update(state: Any?) {
        if let state = state as? State {
            set(visible: true)
            render(state: state)
        } else {
            set(visible: false)
        }
    }

    func typeExist(state: Any?) -> Bool {
        guard let state = state else {
            return false
        }

        let stateType = Mirror(reflecting: type(of: state)).subjectType
        return stateType == self.stateType || stateType == optionalStateType
    }

    private var stateType: Any.Type {
        return Mirror(reflecting: State.self).subjectType
    }

    private var optionalStateType: Any.Type {
        return Mirror(reflecting: State?.self).subjectType
    }
}

/**
 Родительский протокол, описывающий пользовательские эвенты
 */
public protocol ACRHViewOutput {
    func viewIsReady()
    func viewSetNeedsRedraw()
}
