//
//  PreferencesEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class PreferencesEventHandler: ARCHEventHandler<PreferencesState>, PreferencesModuleInput {

    weak var moduleOutput: PreferencesModuleOutput?

    var preferences: [Preference] = []

    override func viewIsReady() {
        super.viewIsReady()
    }
}
