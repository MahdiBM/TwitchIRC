
/// An IRC message to be sent to Twitch.
public enum OutgoingMessage: Sendable {
    /// Sends a message to a channel. Channel name must be lowercased.
    case privateMessage(to: String, message: String, messageIdToReply: String? = nil)
    /// Joins a channel's chat. Channel name must be lowercased.
    case join(to: String)
    /// Parts from a channel's chat. Channel name must be lowercased.
    case part(from: String)
    /// `oauth` pass for IRC access.
    case pass(pass: String)
    /// This for the most part, is only for IRC compatibility and doesn't do much in Twitch.
    /// You still need to send it sometimes, but it doesn't precisely do anything.
    case nick(name: String)
    /// Request additional capabilities.
    case capabilities([Capability])
    /// Ping Twitch.
    case ping
    /// Pong Twitch.
    case pong
    
    /// Serializes this message into a string that can be sent to Twitch over IRC.
    public func serialize() -> String {
        switch self {
        case let .privateMessage(channel, message, messageIdToReply):
            let prefix: String
            if let messageId = messageIdToReply, !messageId.isEmpty {
                prefix = "@reply-parent-msg-id=" + messageId + " "
            } else {
                prefix = ""
            }
            return prefix + "PRIVMSG #\(channel) :\(message)"
        case let .join(channel):
            return "JOIN #\(channel)"
        case let .part(channel):
            return "PART #\(channel)"
        case let .pass(pass):
            return "PASS oauth:\(pass)"
        case let .nick(name):
            return "NICK \(name)"
        case let .capabilities(caps):
            let capsString = caps.map(\.twitchDescription).joined(separator: " ")
            return "CAP REQ :\(capsString)"
        case .ping:
            return "PING :tmi.twitch.tv"
        case .pong:
            return "PONG :tmi.twitch.tv"
        }
    }
}
