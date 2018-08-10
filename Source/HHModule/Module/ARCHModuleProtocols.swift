//
//  ARCHModuleProtocols.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

/**
 Родительский протокол, описывающий состояние модуля
 */
public protocol ARCHState {
    init()
}

public protocol ARCHViewInputAbstact: class {
    func abstractRender(state: ARCHState)
}

public protocol ARCHViewInput: ARCHViewInputAbstact {
    associatedtype State: ARCHState
    func render(state: State)
}

public extension ARCHViewInput where State: ARCHState {

    func abstractRender(state: ARCHState) {
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
