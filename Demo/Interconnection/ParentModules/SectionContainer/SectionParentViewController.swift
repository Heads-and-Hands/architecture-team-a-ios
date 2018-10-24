//
//  SectionParentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

final class SectionParentViewController: ARCHViewController<SectionParentState, SectionParentEventHandler> {

    let tableView = UITableView(frame: .zero, style: .plain)

    lazy var dataSource: ARCHTableViewDataSource = {
        let dataSource = ARCHTableViewDataSource(view: tableView)
        dataSource.dataAdapter = output
        return dataSource
    }()

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = dataSource

        view.addSubview(tableView)

        let closeButton = DefaultButton(title: "Close")
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(self.closeButtonTapHandler(_:)), for: .touchUpInside)

        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -8.0),

            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15.0)
        ])
    }

    // MARK: - Render

    override func render(state: ViewState) {
        super.render(state: state)

        tableView.reloadData()
    }

    // MARK: - Actions

    @objc
    private func closeButtonTapHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
