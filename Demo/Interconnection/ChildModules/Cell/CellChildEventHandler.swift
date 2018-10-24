//
//  CellChildEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

final class CellChildEventHandler: ARCHEventHandler<CellChildState>, CellChildModuleInput, ARCHChildModule {

    weak var moduleOutput: CellChildModuleOutput?

    init(title: String) {
        super.init()
        state.viewModel = ChildOneTVCellViewModel(title: title, isOn: false, eventHandler: self)
    }

    // MARK: - ARCHChildModule

    func configure(for dataSource: ARCHTableViewDataSource) {
        dataSource.register(cell: ChildOneTVCell.self, for: ChildOneTVCellViewModel.self)
    }
}

extension CellChildEventHandler: ChildOneTVCellEventHandler {

    func didChangeCellState(with viewModel: ChildOneTVCellViewModel) {
        guard viewModel.id == state.viewModel.id else {
            return
        }

        state.viewModel = viewModel
        childModuleOutput?.didChange(childState: state)
    }
}
