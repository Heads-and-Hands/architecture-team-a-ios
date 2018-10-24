//
//  ChildOneTVCellViewModel.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

struct ChildOneTVCellViewModel: ARCHCellViewModel, ARCHModelInitilizable {

    typealias Data = ChildOneTVCellViewModel

    init(data: Data) {
        self.id = data.id
        self.title = data.title
        self.eventHandler = data.eventHandler
        self.isOn = data.isOn
    }

    init(title: String, isOn: Bool, eventHandler: ChildOneTVCellEventHandler?) {
        self.title = title
        self.isOn = isOn
        self.eventHandler = eventHandler
    }

    // MARK: - Public

    var id: UUID = UUID()

    var isOn: Bool = false

    var title: String

    weak var eventHandler: ChildOneTVCellEventHandler?
}
