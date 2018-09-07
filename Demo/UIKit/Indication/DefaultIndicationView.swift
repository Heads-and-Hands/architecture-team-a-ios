//
//  IndicationState.swift
//  HHIndicationDemo
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHModule
import HHIndication

class DefaultIndicationView: UIView, ARCHIndicationView {
    private let titleLabel = UILabel()
    private let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    // MARK: - Life cycle

    required init?(coder _: NSCoder) {
        fatalError("NSCoder not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        let stackView = configureStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Private methods

    private func configureStackView() -> UIStackView {
        indicatorView.hidesWhenStopped = true

        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            indicatorView
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 44
        return stackView
    }

    // MARK: - ARCHViewInput

    func update(state: Any) -> Bool {
        guard let state = state as? IndicationState else {
            return false
        }

        switch state.type {
        case .loading:
            titleLabel.isHidden = true
            indicatorView.startAnimating()
        default:
            titleLabel.isHidden = false
            titleLabel.text = state.title
            indicatorView.stopAnimating()
        }

        return true
    }
}
