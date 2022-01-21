
/// A Twitch `USERSTATE` message.
public struct UserState {
    
    /// Channel lowercased name.
    public var channel = String()
    /// User's badge info.
    public var badgeInfo = [String]()
    /// User's badges.
    public var badges = [String]()
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with upper/lower-case letters.
    public var displayName = String()
    /// User's emote sets.
    public var emoteSets = [String]()
    /// Remaining unhandled info in the message. Optimally empty.
    public var unknownStorage = [(lhs: String, rhs: String)]()
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#", contentLhs.count > 2 else {
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
        
        func asArray(_ string: String) -> [String] {
            string.components(separatedBy: ",")
        }
        
        self.badgeInfo = asArray(get(for: "@badge-info"))
        self.badges = asArray(get(for: "badges"))
        self.color = get(for: "color")
        self.displayName = get(for: "display-name")
        self.emoteSets = asArray(get(for: "emote-sets"))
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        self.unknownStorage = container.enumerated().filter({
            offset, element in
            !usedIndices.contains(offset) &&
            !deprecatedKeys.contains(element.lhs)
        }).map(\.element)
    }
    
}
