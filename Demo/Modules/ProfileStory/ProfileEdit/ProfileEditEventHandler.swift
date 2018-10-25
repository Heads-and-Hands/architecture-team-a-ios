//
//  ProfileEditEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ProfileEditEventHandler: ARCHEventHandler<ProfileEditState>, ProfileEditModuleInput {

    weak var moduleOutput: ProfileEditModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
