
/// A Twitch `ACK` message.
public struct Capabilities {
    
    public var capabilities: [Capability] = []
    
    public init() { }
    
    init? (contentRhs: String) {
        guard contentRhs.hasPrefix("* ACK :")
        else { return nil }
        let capabilityStrings = contentRhs.dropFirst(7).componentsSeparatedBy(separator: " ")
        
        for capString in capabilityStrings {
            if let capability = Capability.allCases.first(where: {
                $0.twitchDescription == capString
            }) {
                self.capabilities.append(capability)
            } else {
                return nil
            }
        }
    }
}

// MARK: - Sendable conformance
#if swift(>=5.5)
extension Capabilities: Sendable { }
#endif
