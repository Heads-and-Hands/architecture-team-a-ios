//
//  EmptyModuleEventHandler.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHInputField
import HHModule

final class EmptyModuleEventHandler: ARCHEventHandler<EmptyModuleState>, EmptyModuleModuleInput, ARCHInputFieldOutput {

    weak var moduleOutput: EmptyModuleModuleOutput?

    var fieldsTags: [String: FieldTag] = [:]

    private var fields: [FieldTag: (String, Bool)] = [:]

    override func viewIsReady() {
        super.viewIsReady()

        state.text = "Hello world"
    }

    // MARK: - Public

    public func register(fieldId id: String, as field: FieldTag) {
        fieldsTags[id] = field
    }

    // MARK: - ARCHInputFieldOutput

    func didChangeValue(_ value: String, isValid: Bool, for id: String) {
        guard let tag = fieldsTags[id] else {
            return
        }
        fields[tag] = (value, isValid)
    }
}
