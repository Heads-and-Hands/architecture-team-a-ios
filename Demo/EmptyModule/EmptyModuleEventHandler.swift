//
//  EmptyModuleEventHandler.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

final class EmptyModuleEventHandler: ARCHEventHandler<EmptyModuleState>, EmptyModuleModuleInput {

    weak var moduleOutput: EmptyModuleModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
