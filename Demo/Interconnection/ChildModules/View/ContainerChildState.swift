//
//  ContainerChildState.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule


struct ContainerChildState: ARCHState {

    var id: UUID

    var text: String = ""

    // MARK: - Initialization

    init() {
        self.id = UUID()
    }

    init(id: UUID) {
        self.id = id
    }
}
