//
//  ARCHHeaderFooterView.swift
//  HHList
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public protocol ARCHHeaderFooterViewAbstract {
    var abstractViewModel: ARCHHeaderFooterViewModel? { get set }
}

public protocol ARCHHeaderFooterView: ARCHHeaderFooterViewAbstract {
    associatedtype ViewModel: ARCHHeaderFooterViewModel

    var viewModel: ViewModel? { get set }

    func render(viewModel: ViewModel)
}

public extension ARCHHeaderFooterView where ViewModel: ARCHHeaderFooterViewModel {

    var abstractViewModel: ARCHHeaderFooterViewModel? {
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
