//
//  EmptyModuleEventHandler.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

final class EmptyModuleEventHandler: ARCHEventHandler<EmptyModuleState>, EmptyModuleModuleInput {

    weak var moduleOutput: EmptyModuleModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()

        state.text = "Hello world 1"
    }

    func updateText() {
        if state.text == "Hello world 2" {
            return
        }

        state.text = "Hello world 2"
    }

    // MARK: - EmptyModuleModuleInput

    var someValue: Int = 0 {
        didSet {
            print("Change some value")
        }
    }

    func set(moduleOutput: ARCHModuleOutput) {
        self.moduleOutput = moduleOutput as? EmptyModuleModuleOutput
    }
}
