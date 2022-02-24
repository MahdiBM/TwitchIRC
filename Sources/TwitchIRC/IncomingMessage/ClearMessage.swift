
/// A Twitch `CLEARMESSAGE` message.
public struct ClearMessage: Sendable {
    
    /// The channel's lowercased name.
    public var channel = String()
    /// The deleted message.
    public var message = String()
    /// The user's lowercased name.
    public var userLogin = String()
    /// The cleared message's identifier.
    public var targetMessageId = String()
    /// Broadcaster's Twitch identifier.
    public var roomId = String()
    /// The timestamp of this message.
    public var tmiSentTs = UInt()
    /// Contains info about unused info and parsing problems.
    public var parsingLeftOvers = ParsingLeftOvers()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#" else {
            return nil
        } /// check for "#" behind channel name
        guard let (channel, message) = contentRhs.dropFirst().componentsOneSplit(separatedBy: " ")
        else { return nil }
        
        self.channel = String(channel)
        /// `.unicodeScalars.dropFirst()` to remove ":", `componentsOneSplit(separatedBy: " :")`
        /// and other normal methods like a simple `.dropFirst()` fail in rare cases.
        /// Remove `.unicodeScalars` of `PrivateMessage`'s `message` and run tests to find out.
        self.message = String(message.unicodeScalars.dropFirst())
        
        guard contentLhs.count > 2, contentLhs.last == ":" else {
            return nil
        } /// check for ":" at the end
        
        var parser = ParametersParser(String(contentLhs.dropLast(2).dropFirst()))
        
        self.userLogin = parser.string(for: "login")
        self.targetMessageId = parser.string(for: "target-msg-id")
        self.roomId = parser.string(for: "room-id")
        self.tmiSentTs = parser.uint(for: "tmi-sent-ts")
        
        self.parsingLeftOvers = parser.getLeftOvers()
    }
}
