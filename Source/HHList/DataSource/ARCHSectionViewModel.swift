//
//  ARCHSectionViewModel.swift
//  HHModuleDemo
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public protocol ARCHSectionViewModel {
    static var headerTypes: [(AnyClass, ARCHHeaderFooterViewModel.Type)] { get }
    static var footerTypes: [(AnyClass, ARCHHeaderFooterViewModel.Type)] { get }
    static var cellViewModels: [(AnyClass, ARCHCellViewModel.Type)] { get }

    var headerViewModel: ARCHHeaderFooterViewModel? { get }
    var footerViewModel: ARCHHeaderFooterViewModel? { get }
    var numberOfItems: Int { get }

    func cellViewModel(at index: Int) -> ARCHCellViewModel
}
