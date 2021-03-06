
/// A Twitch `JOIN` message.
public struct Join {
    
    /// Channel's name with no uppercased/Han characters.
    public var channel = String()
    /// User's name with no uppercased/Han characters.
    public var userLogin = String()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#" else {
            return nil
        } /// check for the "#" behind the channel name
        self.channel = String(contentRhs.dropFirst())
        
        guard contentLhs.first == ":", contentLhs.last == "." else {
            return nil
        } /// check for ":" behind and "." after
        
        /// this will be in form `<user>!<user>@<user>`
        let nameContainer = contentLhs.dropFirst().dropLast()
        guard let (name1, nameRhs) = nameContainer.componentsOneSplit(separatedBy: "!"),
              let (name2, name3) = nameRhs.componentsOneSplit(separatedBy: "@"),
              name1 == name2,
              name2 == name3
        else {
            return nil
        }
        self.userLogin = String(name1)
    }
}

// MARK: - Sendable conformance
#if swift(>=5.5)
extension Join: Sendable { }
#endif
