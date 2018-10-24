//
//  ARCHStateSectionDataSource.swift
//  HHInterconnectionDemo
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

protocol ARCHStateSectionDataSource {

    var sectionViewModel: ARCHSectionViewModel { get }
}

protocol ARCHStateDataSource {

    var cellViewModel: ARCHCellViewModel { get }
}

protocol ARCHChildModule {

    func configure(for dataSource: ARCHTableViewDataSource)
}
