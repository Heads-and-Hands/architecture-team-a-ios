//
//  EmptyModuleModuleIO.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

protocol EmptyModuleModuleInput: ARCHModuleInput {
    var someValue: Int { get set }
}

protocol EmptyModuleModuleOutput: ARCHModuleOutput {
}
