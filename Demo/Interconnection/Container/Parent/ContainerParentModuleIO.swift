//
//  ContainerParentModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

protocol ContainerParentModuleInput {
}

protocol ContainerParentModuleOutput: class {
}

protocol ContainerParentViewOutput {

    func needsChangeChildState()
}
