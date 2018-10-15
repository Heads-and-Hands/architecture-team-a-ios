//
//  ARCHRequestsListViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList
import HHModule

final class ARCHRequestsListViewController:
ARCHViewController<ARCHRequestsListState, ARCHRequestsListEventHandler>, UITableViewDataSource, UITableViewDelegate {

    typealias ListController = ARCHTableViewController<ARCHStorageRequest, ARCHStorageTVCellViewModel, ARCHStorageTVCell>

    private let listController = ListController()
    private let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Debug Request"

        view.backgroundColor = .white

        configure(listController: listController)

        configure(closeButton: closeButton)

        setupLayout()
    }

    // MARK: - Configure

    func configure(listController: ListController) {
        listController.dataSource = self
    }

    func configure(closeButton: UIButton) {

        closeButton.setTitle("Close", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.setTitleColor(UIColor.darkGray.withAlphaComponent(0.6), for: .selected)
        closeButton.setTitleColor(UIColor.darkGray.withAlphaComponent(0.6), for: .highlighted)
        closeButton.backgroundColor = .gray
        closeButton.clipsToBounds = true
        closeButton.layer.cornerRadius = 6.0

        closeButton.addTarget(self, action: #selector(self.closeButtonTapHandler(_:)), for: .touchUpInside)
    }

    func setupLayout() {

        let tableView = listController.tableView
        tableView.clipsToBounds = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            closeButton.heightAnchor.constraint(equalToConstant: 36.0),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            tableView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -15.0)
        ])

        if #available(iOS 11.0, *) {
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        } else {
            tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        }

        view.addSubview(tableView)
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)

        listController.data = state.list
    }

    // MARK: - Action

    @objc
    private func closeButtonTapHandler(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Realizated in ARCHTableViewDataSource")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Realizated in ARCHTableViewDataSource")
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectCell(with: indexPath.row)
    }
}
