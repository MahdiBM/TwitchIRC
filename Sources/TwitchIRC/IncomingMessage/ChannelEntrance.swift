
/// Notices sent after entering a channel.
public struct ChannelEntrance {
    
    /// The Twitch message accompanying the notice.
    public var message = String()
    /// The user that has successfully joined the channel. All lowercased.
    public var userLogin = String()
    /// The channel that has been joined. All lowercased.
    public var joinedChannel = String()
    /// The number that Twitch sends alongside this notice.
    public var number = UInt()
    
    public init() { }
    
    init? (id: String, contentRhs: String) {
        guard let number = UInt(id) else {
            return nil
        }
        
        self.number = number
        
        let separator: String
        switch number {
        case 353: separator = " = #"
        case 366: separator = " #"
        default: return nil
        }
        
        guard let (userLogin, rhsRemaining) = contentRhs.componentsOneSplit(separatedBy: separator),
              let (joinedChannel, message) = rhsRemaining.componentsOneSplit(separatedBy: " :")
        else { return nil }
        self.message = message
        self.userLogin = userLogin
        self.joinedChannel = joinedChannel
    }
}

// - MARK: Sendable conformance
#if swift(>=5.5)
extension ChannelEntrance: Sendable { }
#endif
