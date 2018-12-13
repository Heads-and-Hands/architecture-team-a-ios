//
//  ARCHSectionListDataAdapter.swift
//  HHModuleDemo
//
//  Created by basalaev on 30/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public class ARCHSectionListDataAdapter<T: Any, VM: ARCHSectionViewModel>: ARCHSectionDataSourceAdapter {

    public var data: [T] = []
    private let map: (T) -> VM?

    public init(map: @escaping (T) -> VM?) {
        self.map = map
    }

    // MARK: - ARCHSectionDataSourceAdapter

    public var sectionsCount: Int {
        return data.count
    }

    public func sectionViewModelAt(index: Int) -> ARCHSectionViewModel? {
        guard index < data.count else {
            return nil
        }

        let item = data[index]

        if let viewModel = map(item) {
            return viewModel
        } else {
            fatalError("Not found section viewModel. Data: \(item.self); VMType: \(VM.self)")
        }
    }
}
