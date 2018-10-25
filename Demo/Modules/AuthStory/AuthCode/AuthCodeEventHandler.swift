//
//  AuthCodeEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class AuthCodeEventHandler: ARCHEventHandler<AuthCodeState>, AuthCodeModuleInput {

    weak var moduleOutput: AuthCodeModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
