
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
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with upper/lower-case letters.
    public var displayName = String()
    /// User's emotes.
    public var emotes = [String]()
    /// Flags of this message.
    public var flags = [String]()
    /// Whether it's the first time the user is sending a message.
    public var firstMessage = Bool()
    /// Message's id.
    public var id = String()
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
    public var unknownStorage = [(lhs: String, rhs: String)]()
    
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
            separatedBy: " :"
        ) else {
            return nil
        } /// separating with " :", then lhs contains channel name and rhs is the actual message
        self.channel = channel
        self.message = message
        
        guard let (infoPart, _) = contentLhs.componentsOneSplit(separatedBy: " :") else {
            return nil
        } /// separates " :senderName!senderName@senderName." from what is behind it.
        
        let container = infoPart.components(separatedBy: ";")
            .compactMap({ $0.componentsOneSplit(separatedBy: "=") })
        
        var usedIndices = [Int]()
        
        func optionalGet(for key: String) -> String? {
            if let idx = container.firstIndex(where: { $0.lhs == key }) {
                usedIndices.append(idx)
                return container[idx].rhs
            } else {
                return nil
            }
        }
        
        func get(for key: String) -> String {
            optionalGet(for: key) ?? ""
        }
        
        func asArray(_ string: String) -> [String] {
            string.components(separatedBy: ",").filter({ !$0.isEmpty })
        }
        
        func asBool(_ string: String) -> Bool {
            string == "1"
        }
        
        self.badgeInfo = asArray(get(for: "@badge-info"))
        self.badges = asArray(get(for: "badges"))
        self.color = get(for: "color")
        self.displayName = get(for: "display-name")
        self.emotes = asArray(get(for: "emotes"))
        self.flags = asArray(get(for: "flags"))
        self.firstMessage = asBool(get(for: "first-msg"))
        self.id = get(for: "id")
        self.roomId = get(for: "room-id")
        self.tmiSentTs = UInt(get(for: "tmi-sent-ts")) ?? 0
        self.clientNonce = get(for: "client-nonce")
        self.userId = get(for: "user-id")
        self.replyParent = .init(
            displayName: optionalGet(for: "reply-parent-display-name"),
            userLogin: optionalGet(for: "reply-parent-user-login"),
            message: optionalGet(for: "reply-parent-msg-body"),
            id: optionalGet(for: "reply-parent-msg-id"),
            userId: optionalGet(for: "reply-parent-user-id")
        )
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        self.unknownStorage = container.enumerated().filter({
            offset, element in
            !usedIndices.contains(offset) &&
            !deprecatedKeys.contains(element.lhs)
        }).map(\.element)
    }
    
}
