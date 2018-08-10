//
//  ListState.swift
//  architecture
//
//  Created by basalaev on 08.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

struct ListState: ARCHState {
    var list: [SimpleEntity] = []
}

struct SimpleEntity: Hashable {
    let id: String
}
