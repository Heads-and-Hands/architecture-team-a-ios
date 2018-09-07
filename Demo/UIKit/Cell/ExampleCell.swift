//
//  ModuleACell.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHList

class ExampleCell: UITableViewCell, ARCHCell {
    typealias ViewModel = ExampleCellViewModel

    var viewModel: ViewModel?

    func render(viewModel: ViewModel) {
        textLabel?.text = viewModel.title
    }
}

extension ExampleCell: ARCHSkeletonView {
    
}
