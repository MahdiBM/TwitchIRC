
/// A Twitch `GLOBALUSERSTATE` message.
public struct GlobalUserState {
    
    /// Badge info.
    public var badgeInfo = [String]()
    /// User's global badges.
    public var badges = [String]()
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with upper/lower-case letters.
    public var displayName = String()
    /// User's emote sets.
    public var emoteSets = [String]()
    /// User's Twitch identifier.
    public var userId = String()
    /// Remaining unhandled info in the message. Optimally empty.
    public var unknownStorage = [(key: String, value: String)]()
    
    public init() { }
    
    init (contentLhs: String) {
        var parser = ParameterParser(String(contentLhs.dropLast(2)))
        
        self.badgeInfo = parser.array(for: "@badge-info")
        self.badges = parser.array(for: "badges")
        self.color = parser.string(for: "color")
        self.displayName = parser.string(for: "display-name")
        self.emoteSets = parser.array(for: "emote-sets")
        self.userId = parser.string(for: "user-id")
        
        let deprecatedKeys = ["turbo", "user-type"]
        self.unknownStorage = parser.getUnknownElements(excludedKeys: deprecatedKeys)
    }
    
}
