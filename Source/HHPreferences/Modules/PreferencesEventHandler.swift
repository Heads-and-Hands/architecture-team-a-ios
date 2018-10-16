//
//  PreferencesEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class PreferencesEventHandler: ARCHEventHandler<PreferencesState>, PreferencesModuleInput, PreferencesViewOutput {

    weak var moduleOutput: PreferencesModuleOutput?

    var preferencesManager: PreferencesProtocol?

    var preferences: [Preference] = []

    var preferencesKey: String = ""

    override func viewIsReady() {
        super.viewIsReady()

        state.preferences = preferences
        state.title = preferencesKey
    }

    // MARK: - PreferencesVeiwOutput

    func didChange(_ value: String, for name: String) {
        guard let index = preferences.index(where: { $0.name == name }) else {
            return
        }

        preferences[index].value = value
        preferencesManager?.setPreferences(key: preferencesKey, preferences: preferences)
    }

    func didSelectItem(_ name: String) {
        guard let index = preferences.index(where: { $0.name == name }) else {
            return
        }

        for index in 0 ..< preferences.count {
            preferences[index].isSelected = false
        }

        preferences[index].isSelected = true
        preferencesManager?.setPreferences(key: preferencesKey, preferences: preferences)
        state.preferences = preferences
    }
}
