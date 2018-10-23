//
//  HeaderView.swift
//  HHModuleDemo
//
//  Created by basalaev on 07.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHModule
import HHSkeleton

struct HeaderViewState {
    let title: String = "title"
    let detail: String = "detail"
}

class HeaderView: UIView, ARCHViewRenderable, ARCHSkeletonView {
    typealias ViewState = HeaderViewState

    let imageView = UIImageView()
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()

    private struct Constants {
        static let indent: CGFloat = 20
        static let imageSize: CGFloat = 100
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        titleLabel.backgroundColor = .magenta
        detailLabel.backgroundColor = .green

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constants.indent
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.indent),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.indent),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize)
        ])

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: Constants.indent),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.indent),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.indent),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constants.indent)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 120)
    }

    // MARK: - ARCHViewRenderable

    func render(state: ViewState) {
        titleLabel.text = state.title
        detailLabel.text = state.detail
    }

    // MARK: - ARCHSkeletonView

    var skeletonSubviews: [UIView]? {
        return [imageView, titleLabel, detailLabel]
    }

//    func set(isEnableSkeleton: Bool) {
//        if isEnableSkeleton {
//            titleLabel.text = "ARCHSkeletonView ARCHSkeletonView"
//            detailLabel.text = "ARCHSkeletonView ARCHSkeletonView"
//            layoutIfNeeded()
//        }
//    }
}
