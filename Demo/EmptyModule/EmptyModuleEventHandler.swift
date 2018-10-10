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

    private var fields: [FieldTag: Field] = [:]

    override func viewIsReady() {
        super.viewIsReady()

        state.text = "Hello world"

        set(value: "Some Name", for: .name)
    }

    // MARK: - Public

    public func register(field: FieldTag, id: String, input: ARCHInputFieldInput?) {
        fields[field] = Field(id: id, input: input, value: ("", true))
    }

    // MARK: - ARCHInputFieldOutput

    func didChangeValue(_ value: String, isValid: Bool, for id: String) {
        guard let tag = fields.first(where: { $1.id == id })?.key else {
            return
        }
        fields[tag]?.value = (value, isValid)
    }

    // MARK: - Private

    private func set(value: String, for field: FieldTag) {
        fields[field]?.input?.set(value: value)
    }
}
