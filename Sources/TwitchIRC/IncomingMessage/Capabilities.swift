
/// A Twitch `ACK` message.
public struct Capabilities: Sendable {
    
    public var capabilities: [Capability] = []
    
    public init() { }
    
    init? (contentRhs: String) {
        guard contentRhs.hasPrefix("* ACK :")
        else { return nil }
        let capabilityStrings = contentRhs.dropFirst(7).componentsSeparatedBy(separator: " ")
        self.capabilities = capabilityStrings.compactMap { capString in
            if let capability = Capability.allCases.first(where: {
                $0.twitchDescription == capString
            }) {
                return capability
            } else {
                return .unknown(String(capString))
            }
        }
    }
}
