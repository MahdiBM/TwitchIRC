
/// A Twitch `HOSTTARGET` message.
public struct HostTarget {
    
    public enum Action {
        case start(
            /// The lowercased name of the channel that is going to be hosted.
            hostedChannel: String
        )
        case stop
    }
    
    /// The channel's lowercased name.
    public var channel = String()
    /// The number of viewers of the host.
    public var numberOfViewers = Optional<UInt>.none
    /// The action being taken. Currently either starting a host or stopping it.
    public var action: Action!
    
    public init() { }
    
    init? (contentRhs: String) {
        guard contentRhs.first == "#" else {
            return nil
        } /// check for "#" behind channel name
        guard let (channel, rhsRemaining) = String(contentRhs.dropFirst())
                .componentsOneSplit(separatedBy: " :")
        else { return nil }
        self.channel = channel
        if rhsRemaining.first == "-" {
            self.action = .stop
            if rhsRemaining.count > 2 {
                self.numberOfViewers = UInt(rhsRemaining.dropFirst(2))
            }
        } else {
            /// Channel and the optional viewer count
            let components = rhsRemaining.componentsSeparatedBy(separator: " ")
            let compCount = components.count
            if compCount == 1 {
                self.action = .start(hostedChannel: components[0])
            } else if compCount == 2 {
                self.action = .start(hostedChannel: components[0])
                self.numberOfViewers = UInt(components[1])
            } else {
                return nil
            }
        }
    }
}

// - MARK: Sendable conformances
#if swift(>=5.5)
extension HostTarget: Sendable { }
extension HostTarget.Action: Sendable { }
#endif
