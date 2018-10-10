//
//  EmptyModuleState.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHInputField

enum FieldTag: Int {
    case name, email, phone
}

struct Field {
    var id: String
    var input: ARCHInputFieldInput?
    var value: (text: String, isValid: Bool)
}

struct EmptyModuleState: ARCHState {
    var text: String = ""
}
