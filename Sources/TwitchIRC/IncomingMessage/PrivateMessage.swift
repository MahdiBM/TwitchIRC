
/// A Twitch `PRIVMSG` message.
public struct PrivateMessage: MessageWithBadges {
    
    public struct ReplyParent {
        /// Replied user's display name with uppercased/Han characters.
        public var displayName = String()
        /// Replied user's name with no uppercased/Han characters.
        public var userLogin = String()
        /// The replied message.
        public var message = String()
        /// Replied message's id.
        public var id = String()
        /// Replied user's Twitch identifier.
        public var userId = String()
        
        public init() { }
        
        init(
            displayName: String,
            userLogin: String,
            message: String,
            id: String,
            userId: String
        ) {
            self.displayName = displayName
            self.userLogin = userLogin
            self.message = message
            self.id = id
            self.userId = userId
        }
    }
    
    /// Channel's name with no uppercased/Han characters.
    public var channel = String()
    /// The message sent.
    public var message = String()
    /// Badge info.
    public var badgeInfo = [String]()
    /// User's badges.
    public var badges = [String]()
    /// The bits that were donated, if any.
    public var bits = String()
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with uppercased/Han characters.
    public var displayName = String()
    /// User's name with no uppercased/Han characters.
    public var userLogin = String()
    /// User's emotes.
    public var emotes = [String]()
    /// Whether or not the message only contains emotes.
    public var emoteOnly = Bool()
    /// Flags of this message.
    public var flags = [String]()
    /// Whether it's the first time the user is sending a message.
    public var firstMessage = Bool()
    /// Flag for new viewers who have chatted at least twice in the last 30 days.
    public var returningChatter = Bool()
    /// Not sure exactly what is this? usually empty.
    public var messageId = String()
    /// Message's id.
    public var id = String()
    /// Not sure but should be the message id of the
    /// message that the chant was started with.
    public var crowdChantParentMessageId = String()
    /// The id of the custom reward, if any.
    public var customRewardId = String()
    /// Broadcaster's Twitch identifier.
    public var roomId = String()
    /// The timestamp of the message.
    public var tmiSentTs = UInt()
    /// Not sure exactly but some kind of identifier?!
    public var clientNonce = String()
    /// User's Twitch identifier.
    public var userId = String()
    /// Info about the replied message, if any.
    public var replyParent = ReplyParent()
    /// Contains info about unused info and parsing problems.
    public var parsingLeftOvers = ParsingLeftOvers()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.count > 3, contentRhs.first == "#" else {
            return nil
        } /// check existence of " #" before the channel name
        guard let (channel, message) = String(contentRhs.dropFirst()).componentsOneSplit(
            separatedBy: " "
        ) else {
            return nil
        } /// separating with " ", then lhs contains channel name and rhs is the actual message
        self.channel = channel
        /// `.unicodeScalars.dropFirst()` to remove ":", `componentsOneSplit(separatedBy: " :")`
        /// and other normal methods like a simple `.dropFirst()` fail in rare cases.
        /// Remove `.unicodeScalars` and run tests to find out.
        self.message = String(message.unicodeScalars.dropFirst())
        
        guard let (infoPart, userLoginPart) = contentLhs.componentsOneSplit(separatedBy: " :") else {
            return nil
        } /// separates "senderName!senderName@senderName." from what is behind it.
        
        guard let (userLogin1, theRest) = userLoginPart.dropLast().componentsOneSplit(separatedBy: "!"),
              let (userLogin2, userLogin3) = theRest.componentsOneSplit(separatedBy: "@"),
              userLogin1 == userLogin2, userLogin2 == userLogin3 else {
            return nil
        }
        self.userLogin = String(userLogin1)
        
        var parser = ParametersParser(String(infoPart.dropFirst()))
        
        self.badgeInfo = parser.array(for: "badge-info")
        self.badges = parser.array(for: "badges")
        self.bits = parser.string(for: "bits")
        self.color = parser.string(for: "color")
        self.displayName = parser.string(for: "display-name")
        self.emotes = parser.array(for: "emotes")
        self.emoteOnly = parser.bool(for: "emote-only")
        self.flags = parser.array(for: "flags")
        self.firstMessage = parser.bool(for: "first-msg")
        self.returningChatter = parser.bool(for: "returning-chatter")
        self.messageId = parser.string(for: "msg-id")
        self.id = parser.string(for: "id")
        self.crowdChantParentMessageId = parser.string(for: "crowd-chant-parent-msg-id")
        self.customRewardId = parser.string(for: "custom-reward-id")
        self.roomId = parser.string(for: "room-id")
        self.tmiSentTs = parser.uint(for: "tmi-sent-ts")
        self.clientNonce = parser.string(for: "client-nonce")
        self.userId = parser.string(for: "user-id")
        self.replyParent = .init(
            displayName: parser.string(for: "reply-parent-display-name"),
            userLogin: parser.string(for: "reply-parent-user-login"),
            message: parser.string(for: "reply-parent-msg-body"),
            id: parser.string(for: "reply-parent-msg-id"),
            userId: parser.string(for: "reply-parent-user-id")
        )
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        let occasionalKeys = [["crowd-chant-parent-msg-id"], ["bits"], ["emote-only"], ["msg-id"], ["custom-reward-id"], ["client-nonce"], ["flags"], ["first-msg"], ["reply-parent-display-name", "reply-parent-user-login", "reply-parent-msg-body", "reply-parent-msg-id", "reply-parent-user-id"]]
        
        self.parsingLeftOvers = parser.getLeftOvers(
            excludedUnusedKeys: deprecatedKeys,
            groupsOfExcludedUnavailableKeys: occasionalKeys
        )
    }
}

// MARK: - Sendable conformances
#if swift(>=5.5)
extension PrivateMessage: Sendable { }
extension PrivateMessage.ReplyParent: Sendable { }
#endif
