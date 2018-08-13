//
//  User.swift
//  architecture
//
//  Created by basalaev on 14.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHNetwork

struct User: ARCHUser {
    let id: String

    var primaryKey: String {
        return id
    }
}
