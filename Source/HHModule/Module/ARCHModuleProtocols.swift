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

    var id: UUID { get }

    var childStates: [ARCHState] { get set }

    init()
}

public extension ARCHState {

    var id: UUID {
        return UUID(uuidString: "5cb26dd4-d5f3-11e8-9f8b-f2801f1b9fd1") ?? UUID()
    }

    var childStates: [ARCHState] {
        get { return [] }
        set {}
    }

    init(id: UUID) {
        self.init()
    }
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
    associatedtype State: Any
    func render(state: State)
}

public extension ARCHViewRenderable where State: Any {

    func update(state: Any) -> Bool {
        if let state = state as? State {
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
    func shouldRender(_ state: Any) -> Bool
}

public protocol ARCHModuleInput {

    func getState() -> ARCHState
}

public protocol ARCHChildModuleOutput: class {

    func didChange(childState: ARCHState)
}
