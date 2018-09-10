//
//  ChildEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ChildEventHandler: ARCHEventHandler<ChildState>, ChildViewOutput, ChildModuleInput {

    weak var moduleOutput: ChildModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
