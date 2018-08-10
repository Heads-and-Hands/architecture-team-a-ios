//
//  ListExtState.swift
//  architecture
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

struct ListExtState: ARCHState {
    var list: [ListExtItem] = []
}

struct ListExtItem: Hashable {
    let id: String

    var hashValue: Int {
        return id.hashValue
    }
}
