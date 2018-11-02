//
//  ProfileTitleEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ProfileTitleEventHandler: ARCHEventHandler<ProfileTitleState>, ProfileTitleModuleInput {

    weak var moduleOutput: ProfileTitleModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
