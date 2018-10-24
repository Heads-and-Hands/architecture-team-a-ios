//
//  SectionChildEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

protocol ARCHChildModule {

    func configure(for dataSource: ARCHTableViewDataSource)
}

final class SectionChildEventHandler: ARCHEventHandler<SectionChildState>, SectionChildModuleInput, ChildOneTVCellEventHandler, ARCHChildModule {

    weak var moduleOutput: SectionChildModuleOutput?

    override init() {
        super.init()
        let cellViewModels = [
            ChildOneTVCellViewModel(title: "Settings one", isOn: false, eventHandler: self),
            ChildOneTVCellViewModel(title: "Settings two", isOn: false, eventHandler: self),
            ChildOneTVCellViewModel(title: "Settings three", isOn: false, eventHandler: self),
            ChildOneTVCellViewModel(title: "Settings thour", isOn: false, eventHandler: self),
            ChildOneTVCellViewModel(title: "Settings five", isOn: false, eventHandler: self)
        ]
        state.viewModel = ChildOneSectionViewModel(cellViewModels: cellViewModels)
    }

    // MARK: - ARCHChildModule

    func configure(for dataSource: ARCHTableViewDataSource) {
        dataSource.register(cell: ChildOneTVCell.self, for: ChildOneTVCellViewModel.self)
        dataSource.register(header: ChildOneTVHeader.self, for: ChildOneTVHeaderViewModel.self)
    }

    // MARK: - ChildOneTVCellEventHandler

    func didChangeCellState(with viewModel: ChildOneTVCellViewModel) {
        guard let index = state.viewModel.cellViewModels.lastIndex(where: { $0.id == viewModel.id }) else {
            return
        }

        state.viewModel.cellViewModels[index] = viewModel
        childModuleOutput?.didChange(childState: state)
    }
}
