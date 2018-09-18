//
//  ModuleACell.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHList
#if HHSkeleton
import HHSkeleton
#endif

class ExampleCell: UITableViewCell, ARCHCell {
    typealias ViewModel = ExampleCellViewModel

    var viewModel: ViewModel?

    let label = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

        let hIndent: CGFloat = 20
        let vIindent: CGFloat = 5

        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: hIndent),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -hIndent),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: vIindent),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -vIindent)
        ])
    }

    func render(viewModel: ViewModel) {
        label.text = viewModel.title
    }
}

#if HHSkeleton
extension ExampleCell: ARCHSkeletonView {

    /**
     Дочерние вьюхи, которые нужно отображать в режиме скелетон
     */
    var skeletonSubviews: [UIView]? {
        return [label]
    }

    func set(isEnableSkeleton: Bool) {
        label.text = "ARCHSkeletonView ARCHSkeletonView ARCHSkeletonView"
    }
}
#endif
