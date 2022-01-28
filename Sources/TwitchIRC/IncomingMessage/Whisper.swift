
public struct Whisper {
    
    /// The receiver of this whisper. All lowercased.
    public var receiver = String()
    /// The message sent.
    public var message = String()
    /// Sender's badges.
    public var badges = [String]()
    /// Sender's in-chat name color.
    public var color = String()
    /// Sender's display name with with upper/lower-case letters.
    public var displayName = String()
    /// Sender's emotes.
    public var emotes = [String]()
    /// Message's identifier.
    public var messageId = String()
    /// This whisper-thread's identifier.
    public var threadId = String()
    /// Sender's Twitch identifier.
    public var userId = String()
    /// Contains info about unused info and parsing problems.
    public var parsingLeftOvers = ParsingLeftOvers()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard let (receiver, message) = contentRhs.componentsOneSplit(separatedBy: " ") else {
            return nil
        } /// separating with " ", then lhs is the receiver and rhs is the actual message
        
        self.receiver = receiver
        /// `.unicodeScalars.dropFirst()` to remove ":", `componentsOneSplit(separatedBy: " :")`
        /// and other normal methods like a simple `.dropFirst()` fail in rare cases.
        /// Remove `.unicodeScalars` of `PrivateMessage`'s `message` and run tests to find out.
        self.message = String(message.unicodeScalars.dropFirst())
        
        var parser = ParametersParser(String(contentLhs.dropLast(2).dropFirst()))
        
        self.badges = parser.array(for: "badges")
        self.color = parser.string(for: "color")
        self.displayName = parser.string(for: "display-name")
        self.emotes = parser.array(for: "emotes")
        self.messageId = parser.string(for: "message-id")
        self.threadId = parser.string(for: "thread-id")
        self.userId = parser.string(for: "user-id")
        
        let deprecatedKeys = ["turbo", "user-type"]
        self.parsingLeftOvers = parser.getLeftOvers(
            excludedUnusedKeys: deprecatedKeys
        )
    }
}
