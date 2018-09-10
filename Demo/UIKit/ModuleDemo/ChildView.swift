//
//  ChildView.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

protocol ChildViewProtocol: class {

    func childViewNeedsChangeState(_ value: String)
}

struct ChildViewState {

    var text: String
}

class ChildView: UIView, ARCHViewRenderable {

    typealias State = ChildViewState

    weak var output: ChildViewProtocol?

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.textAlignment = .center

        let button = UIButton()
        button.setTitle("CHANGE PARENT STATE", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.contentHorizontalAlignment = .center

        [label, button].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8.0),

            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc
    private func changeButtonDidTap(_ sender: UIButton) {
        output?.childViewNeedsChangeState(UUID().uuidString)
    }

    // MARK: - ARCHViewRenderable

    func render(state: ChildViewState) {
        label.text = state.text
    }
}
