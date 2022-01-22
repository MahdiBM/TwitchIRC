
public struct ConnectionNotice {
    
    /// The message Twitch accompanying the notice.
    public var message = String()
    /// The user that has been successfully connected. All lowercased.
    public var userLogin = String()
    /// The number that Twitch sends alongside this notice.
    public var number = UInt()
    
    public init() { }
    
    init? (id: String, contentRhs: String) {
        guard let number = UInt(id),
              let (userLogin, message) = contentRhs.componentsOneSplit(separatedBy: " :")
        else { return nil }
        
        self.message = message
        self.userLogin = userLogin
        self.number = number
    }
}
