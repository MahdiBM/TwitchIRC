
/// A Twitch `CLEARMESSAGE` message.
public struct ClearMessage {
    
    /// Channel's name with no uppercased/Han characters.
    public var channel = String()
    /// The deleted message.
    public var message = String()
    /// User's name with no uppercased/Han characters.
    public var userLogin = String()
    /// Cleared message's identifier.
    public var targetMessageId = String()
    /// Broadcaster's Twitch identifier.
    public var roomId = String()
    /// Timestamp of this message.
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

// MARK: - Sendable conformance
#if swift(>=5.5)
extension ClearMessage: Sendable { }
#endif
