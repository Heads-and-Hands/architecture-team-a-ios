//
//  ScrollParentModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 23/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

protocol ScrollParentModuleInput {
}

protocol ScrollParentModuleOutput: class {
}

protocol ScrollParentModuleViewOutput: class {

    func tag(for id: UUID) -> ScrollParentEventHandler.ModuleTag?
}
