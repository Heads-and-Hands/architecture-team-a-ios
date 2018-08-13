//
//  ARCHCell.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

public protocol ARCHCellAbstract {
    var abstractViewModel: ARCHCellViewModel? { get set }
}

public protocol ARCHCell: ARCHCellAbstract {
    associatedtype ViewModel: ARCHCellViewModel

    var viewModel: ViewModel? { get set }

    func render(viewModel: ViewModel)
}

public extension ARCHCell where ViewModel: ARCHCellViewModel {

    var abstractViewModel: ARCHCellViewModel? {
        get {
            return viewModel
        }
        set {
            guard let viewModel = newValue as? ViewModel else {
                return
            }

            self.viewModel = viewModel
            render(viewModel: viewModel)
        }
    }
}
