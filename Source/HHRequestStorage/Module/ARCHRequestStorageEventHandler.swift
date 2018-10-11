//
//  ARCHRequestStorageEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestStorageEventHandler: ARCHEventHandler<ARCHRequestStorageState>, ARCHRequestStorageModuleInput {

    weak var moduleOutput: ARCHRequestStorageModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
