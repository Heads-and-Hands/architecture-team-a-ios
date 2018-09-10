//
//  ParentState.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

struct ParentModuleState: ParentModuleStateProtocol {

    typealias ParentPrimitiveState = ParentViewState

    var parentPrimitiveState: ParentViewState = ParentViewState(text: "")
}
