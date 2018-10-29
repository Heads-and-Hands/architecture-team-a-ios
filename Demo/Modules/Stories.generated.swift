// Generated using Sourcery & Python
// DO NOT EDIT

import HHModule

// MARK: - ProfileStory 

internal struct ProfileStory: ARCHModuleID {
    internal static var edit = ProfileEditConfigurator.self
    internal static var title = ProfileTitleConfigurator.self
}

// MARK: - MainStory 

internal struct MainStory: ARCHModuleID {
    internal static var catalog = MainCatalogConfigurator.self
    internal static var title = MainTitleConfigurator.self
}

// MARK: - AuthStory 

internal struct AuthStory: ARCHModuleID {
    internal static var code = AuthCodeConfigurator.self
    internal static var main = AuthMainConfigurator.self
}

