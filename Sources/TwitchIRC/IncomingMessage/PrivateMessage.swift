
/// A Twitch `PRIVMSG` message.
public struct PrivateMessage: MessageWithBadges {

    public struct EmoteReference: Identifiable, Equatable {
        /// The emote ID used in Twitch's API
        public var id = String()
        /// The emote name, which is the text used to represent the emote in a message
        public var name = String()
        /// The index in the message at which the emote starts
        public var startIndex = Int()
        /// The index in the message at which the emote ends
        public var endIndex = Int()

        public init() { }

        init(
            id: String,
            name: String,
            startIndex: Int,
            endIndex: Int
        ) {
            self.id = id
            self.name = name
            self.startIndex = startIndex
            self.endIndex = endIndex
        }
    }
    
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
    /// The emotes present in the message.
    public var emotes = [EmoteReference]()
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
        self.emotes = parseEmotes(from: parser.string(for: "emotes"))
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
        
        let deprecatedKeys = ["turbo", "mod", "vip", "subscriber", "user-type"]
        let occasionalKeys = [["crowd-chant-parent-msg-id"], ["bits"], ["emote-only"], ["msg-id"], ["custom-reward-id"], ["client-nonce"], ["flags"], ["first-msg"], ["reply-parent-display-name", "reply-parent-user-login", "reply-parent-msg-body", "reply-parent-msg-id", "reply-parent-user-id"]]
        
        self.parsingLeftOvers = parser.getLeftOvers(
            excludedUnusedKeys: deprecatedKeys,
            groupsOfExcludedUnavailableKeys: occasionalKeys
        )
    }

    private func parseEmotes(from emoteString: String) -> [EmoteReference] {
        /// First, we need to make sure we have an homogeneous array. In the message, emotes come as
        /// a string that looks like `<id>:<start>-<end>/<id>:<start>-<end>`. However, when the same
        /// emote repeats multiple times, it's more like
        /// `<id>:<start>-<end>,<start>-<end>,<start>-<end>/<id>:<start>-<end>` and the parser has
        /// issues giving it back as a list (the parser uses commas to sepparate, and doesn't take
        /// the `/` into account).
        ///
        /// To solve this, we ask the parser to read it as a string and we treat the whole thing.
        ///
        /// Splitting by `/` returns an array like
        /// `["<id>:<start>-<end>", "<start>-<end>", "<start>-<end>", "<id>:<start>-<end>"]`,
        /// which makes it hard to treat all the elements the same since some of them have no `<id>`.
        /// We solve this by using the last seen id as the id for elements that don't have one.
        ///
        /// Ater that, it's just a matter of parsing the indices and finding the equivalent text in
        /// the chat message. With those, we can create our `EmoteReference` instance and save it.
        var parsed: [EmoteReference] = []

        let emoteArray = emoteString.split(separator: "/")
            .flatMap { $0.split(separator: ",") }
            .map { String($0) }

        var lastID: String? = nil
        for emote in emoteArray {
            /// This gives us either `["<id>", "<start>", "<end>"]` or `["<start>", "<end>"]`
            var parts = emote.split(separator: ":")
                .flatMap { $0.split(separator: "-") }
                .map { String($0) }

            /// If we have an id, save it
            if parts.count == 3 {
                lastID = parts.removeFirst()
            }

            /// Try and retrieve the parts and add them to our list of emotes
            if let lastID,
                let startIndex = Int(parts[0]),
                let endIndex = Int(parts[1]),
                let name = message[stringIn: startIndex...endIndex]
            {
                parsed.append(.init(
                    id: lastID,
                    name: name,
                    startIndex: startIndex,
                    endIndex: endIndex
                ))
            }
        }

        return parsed
    }
}

// MARK: - Sendable conformances
#if swift(>=5.5)
extension PrivateMessage: Sendable { }
extension PrivateMessage.EmoteReference: Sendable { }
extension PrivateMessage.ReplyParent: Sendable { }
#endif
