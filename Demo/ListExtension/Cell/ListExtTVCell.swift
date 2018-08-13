//
//  ListExtTVCell.swift
//  architecture
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHList

class ListExtTVCell: UITableViewCell, ARCHCell {
    typealias ViewModel = ListExtTVCellViewModel

    var viewModel: ViewModel?

    func render(viewModel: ViewModel) {
        textLabel?.text = viewModel.title
    }
}
