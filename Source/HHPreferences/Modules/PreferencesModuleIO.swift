//
//  PreferencesModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol PreferencesModuleInput {

    var preferences: [Preference] { get set }

    var preferencesKey: String { get set }
}

protocol PreferencesModuleOutput: class {

    func didChange(_ preference: Preference)
}

protocol PreferencesViewOutput: ACRHViewOutput {

    func didChange(_ value: String, for name: String)

    func didSelectItem(_ name: String)
}
