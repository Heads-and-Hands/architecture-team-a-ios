//
//  IndicationDemoState.swift
//  architecture
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import HHModule

struct IndicationDemoState: ARCHState {
#if HHSkeleton
    var headerData: String?
#endif
    var list: [SimpleEntity]?
    var indication: IndicationState?

#if HHSkeleton
    var headerSkeletonData: SkeletonData<String> {
        return SkeletonData<String>(indication: indication, data: headerData)
    }

    var listSkeletonData: SkeletonData<[SimpleEntity]> {
        return SkeletonData<[SimpleEntity]>(indication: indication, data: list)
    }
#endif
}

/*
#if HHSkeleton
extension IndicationDemoState: CustomReflectable {

    var customMirror: Mirror {
        let children = DictionaryLiteral<String, Any>(dictionaryLiteral:
            ("headerSkeletonData", headerSkeletonData),
                                                      ("listSkeletonData", listSkeletonData))

        return Mirror(IndicationDemoState.self,
                      children: children,
                      displayStyle: .struct)
    }
}
#endif
*/
