//
//  Stories.swift
//  HHStoriesDemo
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

internal struct Stories: ARCHModuleID {

    internal struct MainStory {

        internal static var mainTitle: MainTitleConfigurator.Type = MainTitleConfigurator.self
        internal static var mainCatalog: MainCatalogConfigurator.Type = MainCatalogConfigurator.self
    }

    internal struct AuthStory {

        internal static var authMain: AuthMainConfigurator.Type = AuthMainConfigurator.self
        internal static var authCode: AuthCodeConfigurator.Type = AuthCodeConfigurator.self
    }

    internal struct ProfileStory {

        internal static var profileTitle: ProfileTitleConfigurator.Type = ProfileTitleConfigurator.self
        internal static var profileEdit: ProfileEditConfigurator.Type = ProfileEditConfigurator.self
    }
}
