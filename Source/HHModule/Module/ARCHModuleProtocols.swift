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

    /**
     Приоритет сортировки, чем больше значение,
     тем раньше должна обработаться данное Вью
     */
    var sortPriority: Int { get }

    /**
     Обновлеяем вьюху на основании переданных данных
     @return true - если удалось обработать переданное состояние
     */
    func update(state: Any) -> Bool

    /**
     Связанные вьюхи для конкретного стейт
     */
    func ignoredViews(by state: Any) -> [ARCHViewInput]

    func set(visible: Bool)
}

public extension ARCHViewInput where Self: UIView {

    func set(visible: Bool) {
        print("[\(type(of: self))] set(visible: \(visible))")
        isHidden = !visible
    }
}

public extension ARCHViewInput {

    var sortPriority: Int {
        return -1
    }

    func ignoredViews(by state: Any) -> [ARCHViewInput] {
        return []
    }

    /*
    func update(states: [Any]) -> [Any] {
        var buffer = states

        for (index, state) in states.enumerated() where typeExist(state: state) {
            update(state: state)
            buffer.remove(at: index)
            break
        }

        return buffer
    }*/

    func set(visible: Bool) {
    }
}

public protocol ARCHViewRenderable: ARCHViewInput {
    associatedtype State: Any
    func render(state: State)
}

public extension ARCHViewRenderable where State: Any {

    func update(state: Any) -> Bool {
        if let state = state as? State {
//            set(visible: true)
            render(state: state)
            return true
        } else {
            return false
        }
    }

    /*
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
    }*/
}

/**
 Родительский протокол, описывающий пользовательские эвенты
 */
public protocol ACRHViewOutput {
    func viewIsReady()
    func viewSetNeedsRedraw()
}
