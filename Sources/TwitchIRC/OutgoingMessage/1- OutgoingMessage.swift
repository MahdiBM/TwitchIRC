
public enum OutgoingMessage {
    /// Sends a message to a channel.
    case privateMessage(to: String, message: String, msgIdToReply: String? = nil)
    /// Sends a whisper to a channel.
    case whisper(to: String, message: String)
    /// Joins a channel's chat.
    case join(to: String)
    /// Parts from a channel's chat.
    case part(from: String)
    /// `oauth` pass for IRC access.
    case pass(pass: String)
    /// This is for the most part only for IRC compatibility and doesn't do much in Twitch.
    /// You still need to send it sometimes, but it doesn't precisely do anything.
    case nick(name: String)
    /// Request additional tags.
    case capabilities([Capability])
    /// Ping Twitch.
    case ping
    /// Pong Twitch.
    case pong
    
    public func serialize() -> String {
        switch self {
        case let .privateMessage(channel, message, msgIdToReply):
            let prefix: String
            if let msgId = msgIdToReply {
                prefix = "@reply-parent-msg-id=" + msgId + " "
            } else {
                prefix = ""
            }
            return prefix + "PRIVMSG #\(channel) :\(message)"
        case let .whisper(channel, message):
            return "WHISPER #\(channel) :\(message)"
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
            return "CAP REQ :" + capsString
        case .ping:
            return "PING :tmi.twitch.tv"
        case .pong:
            return "PONG :tmi.twitch.tv"
        }
    }
}
