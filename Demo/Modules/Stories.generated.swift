// Generated using Sourcery 0.15.0
// DO NOT EDIT

import HHModule

internal struct ProfileStory: ARCHModuleID {
    internal static var edit = ProfileEditConfigurator.self
    internal static var title = ProfileTitleConfigurator.self
}
internal struct MainStory: ARCHModuleID {
    internal static var catalog = MainCatalogConfigurator.self
    internal static var title = MainTitleConfigurator.self
}
internal struct AuthStory: ARCHModuleID {
    internal static var code = AuthCodeConfigurator.self
    internal static var main = AuthMainConfigurator.self
}
