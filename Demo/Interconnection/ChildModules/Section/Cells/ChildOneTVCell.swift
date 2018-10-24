//
//  ChildOneTVCell.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

protocol ChildOneTVCellEventHandler: class {

    func didChangeCellState(with viewModel: ChildOneTVCellViewModel)
}

class ChildOneTVCell: UITableViewCell, ARCHCell {

    typealias ViewModel = ChildOneTVCellViewModel

    var viewModel: ViewModel?

    private var titleLabel = UILabel()
    private var stateLable = UILabel()
    private var switchView = UISwitch()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)

        let stackView = UIStackView(arrangedSubviews: [
            configureMainView(),
            configureSeparator(),
            configureExplanationView(),
            configureSeparator(),
        ])

        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configureMainView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white

        titleLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
        titleLabel.numberOfLines = 0

        switchView.addTarget(self, action: #selector(self.switchEventHandler(_:)), for: .valueChanged)

        [titleLabel, switchView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 8.0),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -8.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),

            switchView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0),
            switchView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 4.0),
            switchView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -4.0),
            switchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0)
        ])

        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        switchView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        switchView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        return view
    }

    private func configureExplanationView() -> UIView {
        let view = UIView()

        stateLable.font = .systemFont(ofSize: 11.0, weight: .regular)
        stateLable.numberOfLines = 0
        stateLable.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stateLable)

        NSLayoutConstraint.activate([
            stateLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
            stateLable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
            stateLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            stateLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0)
        ])

        return view
    }

    private func configureSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        return view
    }

    // MARK: - ARCHCell

    func render(viewModel: ViewModel) {

        titleLabel.text = viewModel.title
        switchView.isOn = viewModel.isOn

        stateLable.text = viewModel.isOn ? "Your settings switched to on" : "Your settings switched to off"
    }

    // MARK: - Actions

    @objc
    private func switchEventHandler(_ sender: UISwitch) {
        guard var viewModel = viewModel else {
            return
        }

        viewModel.isOn = sender.isOn
        viewModel.eventHandler?.didChangeCellState(with: viewModel)
    }
}
