
/// A Twitch `ROOMSTATE` message.
public struct RoomState: Sendable {
    
    /// The channel's lowercased name.
    public var channel = String()
    /// Whether or not normal viewers can only send emotes.
    public var emoteOnly = Bool()
    /// Whether or not normal viewers need to be followers to chat.
    public var followersOnly = Int()
    /// Whether or not messages of normal viewers with more than 9 characters must be unique.
    public var r9k = Bool()
    /// Broadcaster's Twitch identifier.
    public var roomId = String()
    /// Number of seconds normal chatters need to wait between each sent message.
    public var slow = UInt()
    /// Whether or not normal viewers need to be a sub to chat.
    public var subsOnly = Bool()
    /// A flag for when you enter a channel and Twitch encourages you to send an emote.
    public var rituals = Bool()
    /// Contains info about unused info and parsing problems.
    public var parsingLeftOvers = ParsingLeftOvers()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentLhs.count > 2,
              contentRhs.first == "#"
        else { return nil }
        self.channel = String(contentRhs.dropFirst())
        
        var parser = ParametersParser(String(contentLhs.dropLast(2).dropFirst()))
        
        self.emoteOnly = parser.bool(for: "emote-only")
        self.followersOnly = parser.int(for: "followers-only")
        self.r9k = parser.bool(for: "r9k")
        self.roomId = parser.string(for: "room-id")
        self.slow = parser.uint(for: "slow")
        self.subsOnly = parser.bool(for: "subs-only")
        self.rituals = parser.bool(for: "rituals")
        
        let occasionalKeys = ["emote-only", "r9k", "slow", "subs-only", "rituals", "followers-only"]
        self.parsingLeftOvers = parser.getLeftOvers(
            excludedUnavailableKeys: occasionalKeys
        )
    }
}
