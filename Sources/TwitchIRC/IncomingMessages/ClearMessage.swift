
/// A Twitch `CLEARMESSAGE` message.
public struct ClearMessage {
    
    /// The channel's lowercased name.
    public var channel = String()
    /// The deleted message.
    public var message = String()
    /// The user's lowercased name.
    public var userLogin = String()
    /// The cleared message's identifier.
    public var targetMessageId = String()
    /// Broadcaster's Twitch identifier.
    public var roomId = String()
    /// The timestamp of this message.
    public var tmiSentTs = UInt()
    /// Remaining unhandled info in the message. Optimally empty.
    public var unknownStorage = [(lhs: String, rhs: String)]()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#" else {
            return nil
        } /// check for "#" behind channel name
        guard let (channel, message) = contentRhs.dropFirst().componentsOneSplit(separatedBy: " ")
        else { return nil }
        
        self.channel = String(channel)
        /// `dropFirst` to remove ":", `componentsOneSplit(separatedBy: " :")` fails in rare cases
        /// where user inputs weird chars. One case is included in tests of `privateMessage`.
        self.message = String(message.dropFirst())
        
        guard contentLhs.count > 2, contentLhs.last == ":" else {
            return nil
        } /// check for ":" at the end
        
        let container = String(contentLhs.dropLast(2))
            .components(separatedBy: ";")
            .compactMap({ $0.componentsOneSplit(separatedBy: "=") })
        
        var usedIndices = [Int]()
        
        func get(for key: String) -> String {
            if let idx = container.firstIndex(where: { $0.lhs == key }) {
                usedIndices.append(idx)
                return container[idx].rhs
            } else {
                return ""
            }
        }
        
        self.userLogin = get(for: "@login")
        self.targetMessageId = get(for: "target-msg-id")
        self.roomId = get(for: "room-id")
        self.tmiSentTs = UInt(get(for: "tmi-sent-ts")) ?? 0
        self.unknownStorage = container.enumerated().filter({
            offset, _ in !usedIndices.contains(offset)
        }).map(\.element)
    }
    
}
