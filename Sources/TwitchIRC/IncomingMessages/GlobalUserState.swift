
/// A Twitch `GLOBALUSERSTATE` message.
public struct GlobalUserState {
    
    /// Badge info.
    public var badgeInfo = [String]()
    /// User's global badges.
    public var badges = [String]()
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with upper/lower-case letters.
    public var displayName = String()
    /// User's emote sets.
    public var emoteSets = [String]()
    /// User's Twitch identifier.
    public var userId = String()
    /// Remaining unhandled info in the message. Optimally empty.
    public var unknownStorage = [(lhs: String, rhs: String)]()
    
    public init() { }
    
    init (contentLhs: String) {
        let container = contentLhs.components(separatedBy: ";")
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
        
        func asArray(_ string: String) -> [String] {
            string.components(separatedBy: ",").filter({ !$0.isEmpty })
        }
        
        self.badgeInfo = asArray(get(for: "@badge-info"))
        self.badges = asArray(get(for: "badges"))
        self.color = get(for: "color")
        self.displayName = get(for: "display-name")
        self.emoteSets = asArray(get(for: "emote-sets"))
        self.userId = get(for: "user-id")
        
        let deprecatedKeys = ["turbo", "user-type"]
        self.unknownStorage = container.enumerated().filter({
            offset, element in
            !usedIndices.contains(offset) &&
            !deprecatedKeys.contains(element.lhs)
        }).map(\.element)
    }
    
}
