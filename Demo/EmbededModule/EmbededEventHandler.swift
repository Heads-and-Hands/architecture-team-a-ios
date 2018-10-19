//
//  EmbededEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 19/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class EmbededEventHandler: ARCHEventHandler<EmbededState>, EmbededModuleInput {

    weak var moduleOutput: EmbededModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
