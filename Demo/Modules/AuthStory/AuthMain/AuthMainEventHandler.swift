//
//  AuthMainEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class AuthMainEventHandler: ARCHEventHandler<AuthMainState>, AuthMainModuleInput {

    weak var moduleOutput: AuthMainModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
