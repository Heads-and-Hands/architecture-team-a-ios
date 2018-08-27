//
//  ARCHModuleProtocols.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

/**
 Родительский протокол, описывающий состояние модуля
 */
public protocol ARCHState {
    init()
}

public protocol ARCHViewInput: class {
    func update(state: Any)
}

public protocol ARCHViewRenderable: ARCHViewInput {
    associatedtype State: Any
    func render(state: State)
}

public extension ARCHViewRenderable where State: Any {

    func update(state: Any) {
        if let state = state as? State {
            render(state: state)
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
