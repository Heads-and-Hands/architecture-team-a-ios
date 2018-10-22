//
//  ContainerParentEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ContainerParentEventHandler: ARCHEventHandler<ContainerParentState>, ContainerParentModuleInput {

    weak var moduleOutput: ContainerParentModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
