//
//  ARCHSkeletonView.swift
//  HHModuleDemo
//
//  Created by basalaev on 18.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public protocol ARCHSkeletonView {
    /**
     Дочерние вьюхи, которые нужно отображать в режиме скелетон
     */
    var skeletonSubviews: [UIView]? { get }

    /**
     @param isEnableSkeleton:
     true - устанавливаем заглушечные данные
     false - очищаем всё лишние
     */
    func set(isEnableSkeleton: Bool)

    /**
     Для вьюх которые нужно показать в скелетной загрузке
     возвращаем их контуры, можно сразу применить скругления
     или другие эффекты
     */
    func contours(on rootView: UIView) -> [UIBezierPath]
}

public extension ARCHSkeletonView {

    public var skeletonSubviews: [UIView]? {
        return nil
    }

    public func contours(on rootView: UIView) -> [UIBezierPath] {
        guard let skeletonSubviews = skeletonSubviews else {
            return []
        }

        var mask: [UIBezierPath] = []

        for view in skeletonSubviews {
            if let skeletonView = view as? ARCHSkeletonView {
                mask.append(contentsOf: skeletonView.contours(on: rootView))
            } else {
                let frame = rootView.convert(view.frame, from: view.superview)
                let path = UIBezierPath(rect: frame)
                mask.append(path)
            }
        }
        return mask
    }
}

public extension ARCHSkeletonView where Self: UIView {

    public func set(isEnableSkeleton: Bool) {
        skeletonSubviews?.forEach({ view in
            if let view = view as? ARCHSkeletonView {
                view.set(isEnableSkeleton: isEnableSkeleton)
            }
        })

        if isEnableSkeleton {
            layoutIfNeeded()
        }
    }
}
