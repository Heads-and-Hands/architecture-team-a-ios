//
//  ListExtViewController.swift
//  architecture
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHListExtension

final class ListExtViewController: ARCHViewController<ListExtState, ListExtEventHandler>, UITableViewDataSource {

    typealias ListController = ARCHDiffTableViewController<SimpleEntity, ExampleCellViewModel, ExampleCell>

    let listController = ListController()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configure(listController: listController)
        configure(button: button)
        setupLayout()
    }

    // MARK: - Configure

    func configure(listController: ListController) {
        listController.dataSource = self
    }

    func configure(button: UIButton) {
        button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        button.setTitle("Add items", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
    }

    func setupLayout() {
        let buttonHeight: CGFloat = 50

        let tableView = listController.tableView
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - buttonHeight)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)

        button.frame = CGRect(x: 0, y: view.bounds.maxY - buttonHeight, width: view.bounds.width, height: buttonHeight)
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(button)
    }

    // MARK: - Actions

    @objc
    func action(sender: UIButton) {
        output?.pressAddButton()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Realizated in ARCHTableViewDataSource")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Realizated in ARCHTableViewDataSource")
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section title"
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
