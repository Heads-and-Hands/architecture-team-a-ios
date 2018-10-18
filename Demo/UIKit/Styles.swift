//
//  Styles.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 17/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHStyles

class LabelStyle: ARCHBaseStyle<UILabel> {

    static let header = LabelStyle(rawValue: ARCHStyle<UILabel> {
        $0.font = .systemFont(ofSize: 28.0, weight: .bold)
    })

    static let regular = LabelStyle(rawValue: ARCHStyle<UILabel> {
        $0.font = .systemFont(ofSize: 12.0, weight: .regular)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    })

    static let red = LabelStyle(rawValue: ARCHStyle<UILabel> {
        $0.textColor = .red
    })

    static let green = LabelStyle(rawValue: ARCHStyle<UILabel> {
        $0.textColor = .green
    })

    static let greenBackground = LabelStyle(rawValue: ARCHStyle<UILabel> {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.backgroundColor: UIColor.green
        ]

        $0.attributedText = NSAttributedString(string: " ", attributes: attributes)
    })

    static let dischanged = LabelStyle(rawValue: ARCHStyle<UILabel> {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5.0
        style.alignment = .justified

        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.paragraphStyle: style
        ]

        $0.attributedText = NSAttributedString(string: " ", attributes: attributes)
    })
}
