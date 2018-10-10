//
//  EmptyModuleState.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

enum FieldTag: Int {
    case name, email, phone
}

struct EmptyModuleState: ARCHState {
    var text: String = ""
}
