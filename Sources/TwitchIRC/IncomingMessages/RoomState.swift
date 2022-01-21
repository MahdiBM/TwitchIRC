
/// A Twitch `ROOMSTATE` message.
public struct RoomState {
    
    /// The channel's lowercased name.
    public var channel = String()
    /// Whether or not normal viewers can only send emotes.
    public var emoteOnly = Bool()
    /// Whether or not normal viewers need to be followers to chat.
    public var followersOnly = Bool()
    /// Whether or not messages of normal viewers with more than 9 characters must be unique.
    public var r9k = Bool()
    /// Broadcaster's twitch identifier.
    public var roomId = String()
    /// Number of seconds normal chatters need to wait between each sent message.
    public var slow = UInt()
    /// Whether or not normal viewers need to be a sub to chat.
    public var subsOnly = Bool()
    /// Remaining unhandled info in the message. Optimally empty.
    public var unknownStorage = [(lhs: String, rhs: String)]()
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentLhs.count > 2,
              contentRhs.first == "#" else {
                  return nil
              }
        self.channel = String(contentRhs.dropFirst())
        
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
        
        func asBool(_ string: String) -> Bool {
            string == "1"
        }
        
        self.emoteOnly = asBool(get(for: "emote-only"))
        self.followersOnly = asBool(get(for: "followers-only"))
        self.r9k = asBool(get(for: "r9k"))
        self.roomId = get(for: "room-id")
        self.slow = UInt(get(for: "slow")) ?? 0
        self.subsOnly = asBool(get(for: "subs-only"))
        self.unknownStorage = container.enumerated().filter({
            offset, _ in !usedIndices.contains(offset)
        }).map(\.element)
    }
    
}
