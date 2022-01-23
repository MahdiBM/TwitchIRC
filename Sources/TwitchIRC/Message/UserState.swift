
/// A Twitch `USERSTATE` message.
public struct UserState {
    
    /// Channel lowercased name.
    public var channel = String()
    /// User's badge info.
    public var badgeInfo = [String]()
    /// User's badges.
    public var badges = [String]()
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with upper/lower-case letters.
    public var displayName = String()
    /// User's emote sets.
    public var emoteSets = [String]()
    /// Remaining unhandled info in the message. Optimally empty.
    public var unknownStorage = [(key: String, value: String)]()
    /// Keys that were tried to be retrieved but were unavailable.
    public var unavailableKeys = [String]()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#", contentLhs.count > 2 else {
            return nil
        }
        self.channel = String(contentRhs.dropFirst())
        
        var parser = ParameterParser(String(contentLhs.dropLast(2).dropFirst()))
        
        self.badgeInfo = parser.array(for: "badge-info")
        self.badges = parser.array(for: "badges")
        self.color = parser.string(for: "color")
        self.displayName = parser.string(for: "display-name")
        self.emoteSets = parser.array(for: "emote-sets")
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        self.unknownStorage = parser.getUnknownElements(excludedKeys: deprecatedKeys)
        self.unavailableKeys = parser.getUnavailableKeys()
    }
    
}
