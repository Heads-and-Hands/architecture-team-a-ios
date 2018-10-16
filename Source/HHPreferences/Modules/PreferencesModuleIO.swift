//
//  PreferencesModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public protocol PreferencesModuleInput {

    var preferences: [Preference] { get set }
}

public protocol PreferencesModuleOutput: class {

    func didChange(_ preference: Preference)
}
