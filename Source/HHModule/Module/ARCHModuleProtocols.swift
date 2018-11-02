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
     Обновлеяем вьюху на основании переданных данных
     @return true - если удалось обработать переданное состояние
     */
    @discardableResult
    func update(state: Any) -> Bool

    func set(visible: Bool)
}

public extension ARCHViewInput where Self: UIView {

    func set(visible: Bool) {
        print("[\(type(of: self))] set(visible: \(visible))")
        isHidden = !visible
    }
}

public extension ARCHViewInput {

    func set(visible: Bool) {
    }
}

public protocol ARCHViewRenderable: ARCHViewInput {
    associatedtype ViewState: Any
    func render(state: ViewState)
}

public extension ARCHViewRenderable where ViewState: Any {

    func update(state: Any) -> Bool {
        if let state = state as? ViewState {
            render(state: state)
            return true
        } else {
            return false
        }
    }
}

/**
 Родительский протокол, описывающий пользовательские эвенты
 */
public protocol ACRHViewOutput {
    func viewIsReady()
    func viewSetNeedsRedraw()
}
