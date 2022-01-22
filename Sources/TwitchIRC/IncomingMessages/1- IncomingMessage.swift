
/// A Twitch Message.
public enum Message {
    
    case connectionNotice(ConnectionNotice)
    case channelEntrance(ChannelEntrance)
    case globalUserState(GlobalUserState)
    case privateMessage(PrivateMessage)
    case join(Join)
    case part(Part)
    case clearChat(ClearChat)
    case clearMessage(ClearMessage)
    case hostTarget(HostTarget)
    case notice(Notice)
    case reconnect
    case roomState(RoomState)
    case userNotice(UserNotice)
    case userState(UserState)
    case capabilities(Capabilities)
    case ping
    case pong
    case unknown(message: String)
    
    /// Parses all messages included.
    public static func parse(ircOutput: String) -> [Self] {
        ircOutput.components(separatedBy: "\r\n").filter({ !$0.isEmpty }).map(parseMessage)
    }
    
    private static func parseMessage(message: String) -> Self {
        
        func unknown() -> Self { .unknown(message: message) }
        
        guard let (contentLhs, messageRhs) = message.componentsOneSplit(
            separatedBy: "tmi.twitch.tv"
        ) else {
            return unknown()
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
                return unknown()
            }
        case "353", "366":
            if let message = ChannelEntrance(id: messageIdentifier, contentRhs: contentRhs) {
                return .channelEntrance(message)
            } else {
                return unknown()
            }
        case "GLOBALUSERSTATE":
            let message = GlobalUserState(contentLhs: contentLhs)
            return .globalUserState(message)
        case "PRIVMSG":
            if let message = PrivateMessage(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .privateMessage(message)
            } else {
                return unknown()
            }
        case "JOIN":
            if let message = Join(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .join(message)
            } else {
                return unknown()
            }
        case "PART":
            if let message = Part(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .part(message)
            } else {
                return unknown()
            }
        case "CLEARCHAT":
            if let message = ClearChat(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .clearChat(message)
            } else {
                return unknown()
            }
        case "CLEARMSG":
            if let message = ClearMessage(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .clearMessage(message)
            } else {
                return unknown()
            }
        case "HOSTTARGET":
            if let message = HostTarget(contentRhs: contentRhs) {
                return .hostTarget(message)
            } else {
                return unknown()
            }
        case "NOTICE":
            if let message = Notice(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .notice(message)
            } else {
                return unknown()
            }
        case "RECONNECT":
            return .reconnect
        case "ROOMSTATE":
            if let message = RoomState(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .roomState(message)
            } else {
                return unknown()
            }
        case "USERNOTICE":
            if let message = UserNotice(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .userNotice(message)
            } else {
                return unknown()
            }
        case "USERSTATE":
            if let message = UserState(contentLhs: contentLhs, contentRhs: contentRhs) {
                return .userState(message)
            } else {
                return unknown()
            }
        case "CAP":
            if let message = Capabilities(contentRhs: contentRhs) {
                return .capabilities(message)
            } else {
                return unknown()
            }
        case "":
            if contentLhs == "PING :" {
                return .ping
            } else if contentLhs == "PONG :" {
                return .pong
            } else {
                return unknown()
            }
        default:
            return unknown()
        }
    }
    
}
