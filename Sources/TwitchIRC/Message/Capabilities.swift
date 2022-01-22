
public struct Capabilities {
    
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
    
    public var capabilities: [Capability] = []
    
    public init() { }
    
    init? (contentRhs: String) {
        guard contentRhs.hasPrefix("* ACK :")
        else { return nil }
        let capabilityStrings = contentRhs.dropFirst(7).components(separatedBy: " ")
        self.capabilities = capabilityStrings.compactMap { capString in
            if let capability = Capability.allCases.first(where: {
                $0.twitchDescription == capString
            }) {
                return capability
            } else {
                /// TODO: REPORT
                return nil
            }
        }
    }
}
