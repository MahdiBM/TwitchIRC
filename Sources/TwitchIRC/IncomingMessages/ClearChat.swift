
/// A Twitch `CLEARCHAT` message.
public struct ClearChat {
    
    /// The channel's lowercased name.
    public var channel = String()
    /// The cleared user's lowercased name.
    /// If `nil` then the whole chat has been cleared.
    public var userLogin = Optional<String>.none
    /// The duration of the ban/timeout.
    /// If `nil` and `user` available, then the user is permanently banned.
    public var banDuration = Optional<UInt>.none
    
    // MARK: Convenience stuff
    public var userIsPermanentlyBanned: Bool {
        banDuration == nil && userLogin != nil
    }
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#" else {
            return nil
        } /// check for "#" behind channel name
        
        if let (channel, user) = contentRhs.dropFirst().componentsOneSplit(separatedBy: " :") {
            self.channel = String(channel)
            self.userLogin = String(user)
        } else { /// the whole chat has been cleared therefore there is no " :" to specify the user.
            self.channel = String(contentRhs.dropFirst())
        }
        
        if contentLhs.count > 16 {
            let banDurationString = contentLhs.dropFirst(14).dropLast(2)
            self.banDuration = UInt(banDurationString)
        }
    }
    
}
