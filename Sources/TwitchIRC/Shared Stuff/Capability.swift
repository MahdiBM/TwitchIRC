
/// Additional capabilities you can ask from Twitch.
public enum Capability: CaseIterable {
    case membership
    case tags
    case commands
    
    var twitchDescription: String {
        switch self {
        case .membership: return "twitch.tv/membership"
        case .tags: return "twitch.tv/tags"
        case .commands: return "twitch.tv/commands"
        }
    }
}

// MARK: - Sendable conformance
#if swift(>=5.5)
extension Capability: Sendable { }
#endif
