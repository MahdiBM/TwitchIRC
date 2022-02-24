
/// A message coming from Twitch.
public enum IncomingMessage: Sendable {
    /// A type of message sent after successful connection to Twitch.
    case connectionNotice(ConnectionNotice)
    /// A type of message sent after entering a channel.
    case channelEntrance(ChannelEntrance)
    /// A Twitch error indicating the command you sent is unknown.
    case unknownCommand(UnknownCommand)
    /// The global user state of the account connected to Twitch.
    case globalUserState(GlobalUserState)
    /// A normal chat message.
    case privateMessage(PrivateMessage)
    /// A message indicating successful join to a channel.
    case join(Join)
    /// A message indicating successful part from a channel.
    case part(Part)
    /// A message indicating full-chat removal, of a user or of all chatters together.
    case clearChat(ClearChat)
    /// A message indicating removal of a single other message.
    case clearMessage(ClearMessage)
    /// A message indicating host/unhost actions of a channel.
    case hostTarget(HostTarget)
    /// A message giving general notices.
    case notice(Notice)
    /// A message indicating Twitch closing all connections for a short period.
    case reconnect
    /// A message indicating a channel's general room state.
    case roomState(RoomState)
    /// A message giving notices about user actions.
    case userNotice(UserNotice)
    /// A message indicating a user's state in a channel.
    case userState(UserState)
    /// A message indicating given capabilities after requesting them.
    case capabilities(Capabilities)
    /// A whisper aka Twitch private message.
    case whisper(Whisper)
    /// A ping.
    case ping
    /// A pong.
    case pong
    
    /// Parses all messages included.
    public static func parse(ircOutput: String) -> [(message: Self?, text: String)] {
        ircOutput.componentsSeparatedBy(separator: "\r\n")
            .filter({ !$0.isEmpty })
            .map({ (parseMessage(message: $0), $0) })
    }
    
    private static func parseMessage(message: String) -> Self? {
        
        guard let (contentLhs, messageRhs) = message.componentsOneSplit(
            separatedBy: "tmi.twitch.tv"
        ) else {
            return nil
        }
        
        let messageIdentifier: String
        let contentRhs: String
        let rhsWithoutPossibleLeadingSpace = String(messageRhs.dropFirst())
        if let split = rhsWithoutPossibleLeadingSpace.componentsOneSplit(separatedBy: " ") {
            (messageIdentifier, contentRhs) = split
        } else {
            messageIdentifier = rhsWithoutPossibleLeadingSpace
            contentRhs = ""
        }
        
        switch messageIdentifier {
        case "001", "002", "003", "004", "372", "375", "376":
            if let message = ConnectionNotice(id: messageIdentifier, contentRhs: contentRhs) {
                return .connectionNotice(message)
            } else {
                return nil
            }
        case "353", "366":
            if let message = ChannelEntrance(id: messageIdentifier, contentRhs: contentRhs) {
                return .channelEntrance(message)
            } else {
                return nil
            }
        case "421":
            if let message = UnknownCommand(contentRhs: contentRhs) {
                return .unknownCommand(message)
            } else {
                return nil
            }
        case "GLOBALUSERSTATE":
            let message = GlobalUserState(contentLhs: contentLhs)
            return .globalUserState(message)
        case "PRIVMSG":
            if let message = PrivateMessage(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .privateMessage(message)
            } else {
                return nil
            }
        case "JOIN":
            if let message = Join(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .join(message)
            } else {
                return nil
            }
        case "PART":
            if let message = Part(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .part(message)
            } else {
                return nil
            }
        case "CLEARCHAT":
            if let message = ClearChat(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .clearChat(message)
            } else {
                return nil
            }
        case "CLEARMSG":
            if let message = ClearMessage(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .clearMessage(message)
            } else {
                return nil
            }
        case "HOSTTARGET":
            if let message = HostTarget(contentRhs: contentRhs) {
                return .hostTarget(message)
            } else {
                return nil
            }
        case "NOTICE":
            if let message = Notice(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .notice(message)
            } else {
                return nil
            }
        case "RECONNECT":
            return .reconnect
        case "ROOMSTATE":
            if let message = RoomState(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .roomState(message)
            } else {
                return nil
            }
        case "USERNOTICE":
            if let message = UserNotice(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .userNotice(message)
            } else {
                return nil
            }
        case "USERSTATE":
            if let message = UserState(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .userState(message)
            } else {
                return nil
            }
        case "CAP":
            if let message = Capabilities(contentRhs: contentRhs) {
                return .capabilities(message)
            } else {
                return nil
            }
        case "WHISPER":
            if let message = Whisper(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .whisper(message)
            } else {
                return nil
            }
        case "":
            if contentLhs == "PING :" {
                return .ping
            } else if contentLhs == "PONG :" {
                return .pong
            } else {
                return nil
            }
        default:
            return nil
        }
    }
    
}
