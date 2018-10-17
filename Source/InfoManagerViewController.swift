//
//  InfoManagerViewController.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 17/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

class InfoManagerViewController: UIViewController {

    // MARK: - ViewInput

    var values: [(key: String, value: String)] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Constants

    private let reuseIdentifire = "InfoManagerViewControllerCellReuseIdentifire"

    // MARK: - UIKit

    private let titleLabel = UILabel()
    private let tableView = UITableView()
    private let closeButton = UIButton()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        titleLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "Debug info"

        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(InfoManagerTableViewCell.self, forCellReuseIdentifier: reuseIdentifire)
        tableView.delegate = self
        tableView.dataSource = self

        closeButton.backgroundColor = .gray
        closeButton.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .medium)
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.clipsToBounds = true
        closeButton.layer.cornerRadius = 6.0
        closeButton.addTarget(self, action: #selector(self.closeButtonTapHandler(_:)), for: .touchUpInside)

        [titleLabel, tableView, closeButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })

        if #available(iOS 11.0, *) {
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15.0).isActive = true
        }

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            closeButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8.0),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            closeButton.heightAnchor.constraint(equalToConstant: 36.0)
        ])
    }

    // MARK: - Actions

    @objc
    private func closeButtonTapHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension InfoManagerViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire) as? InfoManagerTableViewCell else {
            return UITableViewCell()
        }

        cell.update(with: values[indexPath.row].key, value: values[indexPath.row].value, row: indexPath.row)

        return cell
    }
}
