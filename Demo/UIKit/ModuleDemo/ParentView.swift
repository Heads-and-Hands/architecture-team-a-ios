//
//  ParentView.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

protocol ParentViewProtocol: class {

    func parentViewNeedsChangeState(_ value: String)
}

struct ParentViewState {

    var text: String
}

class ParentView: UIView, ARCHViewRenderable {

    typealias ViewState = ParentViewState

    weak var output: ParentViewProtocol?

    let label = UILabel()

    init(title: String, buttonTitle: String) {
        super.init(frame: .zero)

        label.text = title
        label.textAlignment = .center

        let button = UIButton()
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(self.changeButtonDidTap(_:)), for: .touchUpInside)

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
        output?.parentViewNeedsChangeState(UUID().uuidString)
    }

    // MARK: - ARCHViewRenderable

    func render(state: ParentViewState) {
        label.text = state.text
    }
}
