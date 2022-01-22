
/// A Twitch `PRIVMSG` message.
public struct PrivateMessage {
    
    public struct ReplyParent {
        /// Replied user's display name with upper/lower-case letters.
        public var displayName: String?
        /// Replied user's lowercased name.
        public var userLogin: String?
        /// The replied message.
        public var message: String?
        /// Replied message's id.
        public var id: String?
        /// Replied user's Twitch identifier.
        public var userId: String?
    }
    
    /// Channel lowercased name.
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
    /// User's display name with upper/lower-case letters.
    public var displayName = String()
    /// User's emotes.
    public var emotes = [String]()
    /// Whether or not the message only contains emotes.
    public var emoteOnly = Bool()
    /// Flags of this message.
    public var flags = [String]()
    /// Whether it's the first time the user is sending a message.
    public var firstMessage = Bool()
    /// Not sure exactly what is this? usually empty.
    public var msgId = String()
    /// Message's id.
    public var id = String()
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
    /// Remaining unhandled info in the message. Optimally empty.
    public var unknownStorage = [(key: String, value: String)]()
    
    // MARK: Convenience stuff
    
    public var isMod: Bool {
        self.badges.contains(where: { $0.hasPrefix("moderator") })
    }
    public var isSubscriber: Bool {
        self.badges.contains(where: { $0.hasPrefix("subscriber") })
    }
    public var isOwner: Bool {
        self.badges.contains(where: { $0.hasPrefix("broadcaster") })
    }
    public var isVIP: Bool {
        self.badges.contains(where: { $0.hasPrefix("vip") })
    }
    public var isTurbo: Bool {
        self.badges.contains(where: { $0.hasPrefix("turbo") })
    }
    
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
        /// `dropFirst` to remove ":", `componentsOneSplit(separatedBy: " :")` fails in rare cases
        /// where user inputs weird chars. One case is included in tests of `privateMessage`.
        self.message = String(message.dropFirst())
        
        guard let (infoPart, _) = contentLhs.componentsOneSplit(separatedBy: " :") else {
            return nil
        } /// separates " :senderName!senderName@senderName." from what is behind it.
        
        var parser = ParameterParser(infoPart)
        
        self.badgeInfo = parser.array(for: "@badge-info")
        self.badges = parser.array(for: "badges")
        self.bits = parser.string(for: "bits")
        self.color = parser.string(for: "color")
        self.displayName = parser.string(for: "display-name")
        self.emotes = parser.array(for: "emotes")
        self.emoteOnly = parser.bool(for: "emote-only")
        self.flags = parser.array(for: "flags")
        self.firstMessage = parser.bool(for: "first-msg")
        self.msgId = parser.string(for: "msg-id")
        self.id = parser.string(for: "id")
        self.customRewardId = parser.string(for: "custom-reward-id")
        self.roomId = parser.string(for: "room-id")
        self.tmiSentTs = parser.uint(for: "tmi-sent-ts")
        self.clientNonce = parser.string(for: "client-nonce")
        self.userId = parser.string(for: "user-id")
        self.replyParent = .init(
            displayName: parser.optionalString(for: "reply-parent-display-name"),
            userLogin: parser.optionalString(for: "reply-parent-user-login"),
            message: parser.optionalString(for: "reply-parent-msg-body"),
            id: parser.optionalString(for: "reply-parent-msg-id"),
            userId: parser.optionalString(for: "reply-parent-user-id")
        )
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        self.unknownStorage = parser.getUnknownElements(excludedKeys: deprecatedKeys)
    }
    
}
