//
//  ListViewController.swift
//  architecture
//
//  Created by basalaev on 08.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit
import HHModule
import HHList

final class ListViewController: ARCHViewController<ListState, ListEventHandler>, UITableViewDataSource {

#if CONTROLLER
    typealias ListController = ARCHTableViewController<SimpleEntity, ExampleCellViewModel, ExampleCell>

    let listController = ListController()
#else
    let tableView = UITableView()

    lazy var dataSource: ARCHTableViewDataSource = {
        let dataSource = ARCHTableViewDataSource(view: tableView)
        dataSource.register(cell: ExampleCell.self, for: ExampleCellViewModel.self)
        dataSource.dataAdapter = dataAdapter
        dataSource.dataSource = self
        return dataSource
    }()

    lazy var dataAdapter = ARCHEmptyListDataAdapter<SimpleEntity, ExampleCellViewModel>()
#endif

    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

#if CONTROLLER
        configure(listController: listController)
#else
        configure(tableView: tableView)
#endif
        configure(button: button)
        setupLayout()
    }

    // MARK: - Configure

#if CONTROLLER
    func configure(listController: ListController) {
        listController.dataSource = self
    }
#else
    func configure(tableView: UITableView) {
        tableView.dataSource = dataSource
    }
#endif

    func configure(button: UIButton) {
        button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        button.setTitle("Add items", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
    }

    func setupLayout() {
        let buttonHeight: CGFloat = 50
#if CONTROLLER
        let tableView = listController.tableView
#endif
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - buttonHeight)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)

        button.frame = CGRect(x: 0, y: view.bounds.maxY - buttonHeight, width: view.bounds.width, height: buttonHeight)
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(button)
    }

    // MARK: - Render

    override func render(state: ViewState) {
        super.render(state: state)

#if CONTROLLER
        listController.data = state.list
#else
        dataAdapter.data = state.list
        tableView.reloadData()
#endif
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
