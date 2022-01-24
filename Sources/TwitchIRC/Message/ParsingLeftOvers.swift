
public struct ParsingLeftOvers {
    
    public struct UnusedPair {
        let key: String
        let value: String
    }
    
    public struct UnparsedKey {
        let key: String
        let type: String
    }
    
    /// Key-Value pairs that were unused.
    public var unusedPairs = [UnusedPair]()
    /// Keys that were unavailable.
    public var unavailableKeys = [String]()
    /// Keys that were failed to be parsed into a certain type.
    public var unparsedKeys = [UnparsedKey]()
    /// Whether or not there are any left overs.
    public var isEmpty: Bool {
        self.unusedPairs.isEmpty
        && self.unparsedKeys.isEmpty
        && self.unparsedKeys.isEmpty
    }
}
