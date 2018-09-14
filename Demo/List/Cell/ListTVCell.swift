//
//  ListTVCell.swift
//  architecture
//
//  Created by HeadsAndHands on 14.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

class ListTVCell: UITableViewCell, ARCHCell {
    typealias ViewModel = ListTVCellViewModel

    let listButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5.0

        return button
    }()

    var viewModel: ViewModel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configurate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configurate() {

        listButton.addTarget(self, action: #selector(changeState(sender:)), for: .touchUpInside)
        addSubview(listButton)

        listButton.translatesAutoresizingMaskIntoConstraints = false
        listButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        listButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0, constant: -20.0).isActive = true
        listButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        listButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10.0).isActive = true

    }

    @objc
    func changeState(sender: UIButton) {
        if var vm = viewModel {
            vm.changeActive(!vm.data.active)
        }

        updateTitleButton()
    }

    func updateTitleButton() {
        if viewModel?.data.active == true {
            listButton.setTitle("Active", for: .normal)
        } else {
            listButton.setTitle("Not active", for: .normal)
        }
    }

    func render(viewModel: ViewModel) {
        updateTitleButton()
    }
}
