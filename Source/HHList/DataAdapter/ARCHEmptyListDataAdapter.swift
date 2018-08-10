//
//  ARCHEmptyListDataAdapter.swift
//  architecture
//
//  Created by basalaev on 08.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public class ARCHEmptyListDataAdapter<T: Any, VM: ARCHCellViewModel>: ARCHListDataSourceAdapter {

    public var data: [T] = []
    private let map: (T) -> VM?

    public init(map: ((T) -> VM?)? = nil) {
        if let map = map {
            self.map = map
        } else {
            self.map = { data in
                if let type = VM.self as? ARCHModelAbstractInitilizable.Type {
                    if let viewModel = type.create(data: data) as? VM {
                        return viewModel
                    }
                }
                return nil
            }
        }
    }

    // MARK: - ARCHListDataSourceAdapter

    public var sectionsCount: Int {
        return 1
    }

    public func numberOfRowsIn(section: Int) -> Int {
        return data.count
    }

    public func cellViewModelAt(indexPath: IndexPath) -> ARCHCellViewModel {
        let data = self.data[indexPath.row]
        let type = VM.self

        if let viewModel = map(data) {
            return viewModel
        } else {
            fatalError("Not found viewModel. Data: \(data.self); VMType: \(type)")
        }
    }
}
