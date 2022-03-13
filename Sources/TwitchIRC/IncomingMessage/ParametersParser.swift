
/// Parses parameters from Twitch-sent values.
struct ParametersParser {
    
    private typealias StoredElement = (offset: Int, element: (key: String, value: String))
    
    /// The storage of the values.
    private let storage: [StoredElement]
    /// Indices of the used storage elements.
    private var usedIndices = Set<Int>()
    /// Keys that were unavailable.
    private var unavailableKeys = [String]()
    /// Keys that were failed to be parsed into a certain type.
    private var unparsedKeys = [(pair: (key: String, value: String), type: String)]()
    
    init(_ input: String) {
        let values = input.componentsSeparatedBy(separator: ";").compactMap {
            $0.componentsOneSplit(separatedBy: "=").map({ (key: $0.lhs, value: $0.rhs) })
        }
        self.storage = .init(values.enumerated())
    }
    
    /// Returns left-overs of this parser.
    /// - Parameters:
    ///   - excludedUnusedKeys: The unused keys that should be excluded
    ///   since Twitch occasionally doesn't sends them to us.
    ///   - excludedUnavailableKeys: The keys that should be excluded
    ///   since Twitch occasionally doesn't sends them to us.
    func getLeftOvers(
        excludedUnusedKeys: [String] = [],
        excludedUnavailableKeys: [String] = []
    ) -> ParsingLeftOvers {
        let unusedPairs = self.storage.filter({
            !(self.usedIndices.contains($0.offset) || excludedUnusedKeys.contains($0.element.key))
        }).map({
            ParsingLeftOvers.UnusedPair.init(
                key: $0.element.key,
                value: $0.element.value
            )
        })
        let unavailableKeys = self.unavailableKeys
            .filter({ !excludedUnavailableKeys.contains($0) })
        let unparsedKeys = self.unparsedKeys.map {
            ParsingLeftOvers.UnparsedKey(key: $0.pair.key, value: $0.pair.value, type: $0.type)
        }
        return ParsingLeftOvers(
            unusedPairs: unusedPairs,
            unavailableKeys: unavailableKeys,
            unparsedKeys: unparsedKeys
        )
    }
    
    
    /// Returns left-overs of this parser.
    /// - Parameters:
    ///   - excludedUnusedKeys: The unused keys that should be excluded
    ///   since Twitch occasionally doesn't sends them to us.
    ///   - groupsOfExcludedUnavailableKeys: The groups of keys that should be excluded
    ///   from `ParsingLeftOvers.unavailableKeys`. Each group's members all should be available
    ///   or all be unavailable, otherwise the group won't take effect.
    ///   still be included in the `ParsingLeftOvers.unavailableKeys`.
    func getLeftOvers(
        excludedUnusedKeys: [String] = [],
        groupsOfExcludedUnavailableKeys: [[String]]
    ) -> ParsingLeftOvers {
        let excludedUnavailableKeys = groupsOfExcludedUnavailableKeys.reduce(
            into: [String]()
        ) { current, nextGroup in
            let groupCount = nextGroup.count
            guard groupCount > 1 else {
                current += nextGroup
                return
            }
            let trueCount = nextGroup
                .map(self.unavailableKeys.contains)
                .filter({ $0 == true })
                .count
            if trueCount == 0 || trueCount == nextGroup.count {
                current += nextGroup
            }
        }
        return self.getLeftOvers(
            excludedUnusedKeys: excludedUnusedKeys,
            excludedUnavailableKeys: excludedUnavailableKeys
        )
    }
    
    private mutating func get(for key: String) -> StoredElement? {
        if let stored = storage.first(where: { $0.element.key == key }) {
            self.usedIndices.insert(stored.offset)
            return stored
        } else {
            self.unavailableKeys.append(key)
            return nil
        }
    }
    
    private mutating func appendUnparsedKey<T>(pair: (key: String, value: String), type: T.Type) {
        self.unparsedKeys.append((pair: pair, type: String(describing: type)))
    }
    
    mutating func optionalString(for key: String) -> String? {
        if let stored = self.get(for: key) {
            return stored.element.value
        } else {
            return nil
        }
    }
    
    mutating func string(for key: String) -> String {
        self.optionalString(for: key) ?? ""
    }
    
    mutating func array(for key: String) -> [String] {
        if let value = self.optionalString(for: key) {
            return value.componentsSeparatedBy(separator: ",").filter({ !$0.isEmpty })
        } else {
            return []
        }
    }
    
    mutating func optionalUInt(for key: String) -> UInt? {
        if let stored = self.get(for: key) {
            if let uint = UInt(stored.element.value) {
                return uint
            } else {
                self.appendUnparsedKey(pair: stored.element, type: UInt.self)
               return nil
           }
        } else {
            return nil
        }
    }
    
    mutating func uint(for key: String) -> UInt {
        self.optionalUInt(for: key) ?? 0
    }
    
    mutating func optionalInt(for key: String) -> Int? {
        if let stored = self.get(for: key) {
            if let int = Int(stored.element.value) {
                return int
            } else {
                self.appendUnparsedKey(pair: stored.element, type: Int.self)
                return nil
            }
        } else {
            return nil
        }
    }
    
    mutating func int(for key: String) -> Int {
        self.optionalInt(for: key) ?? -1
    }
    
    mutating func optionalBool(for key: String) -> Bool? {
        if let stored = self.get(for: key) {
            let value = stored.element.value
            if value == "1" || value == "true" {
                return true
            } else if value == "0" || value == "false" {
                return false
            } else {
                self.appendUnparsedKey(pair: stored.element, type: Bool.self)
                return nil
            }
        } else {
            return nil
        }
    }
    
    mutating func bool(for key: String) -> Bool {
        self.optionalBool(for: key) ?? false
    }
    
    mutating func representable<R>(
        for key: String,
        as type: R.Type = R.self
    ) -> R? where R: RawRepresentable, R.RawValue == String {
        if let stored = self.get(for: key) {
            if let representable = R.init(rawValue: stored.element.value) {
                return representable
            } else {
                self.appendUnparsedKey(pair: stored.element, type: R.self)
                return nil
           }
        } else {
            return nil
        }
    }
    
#if DEBUG
    // MARK: - Test-Only stuff
    func _testOnly_storage() -> [(offset: Int, element: (key: String, value: String))] {
        self.storage
    }
    
    func _testOnly_usedIndices() -> Set<Int> {
        self.usedIndices
    }
    
    func _testOnly_unavailableKeys() -> [String] {
        self.unavailableKeys
    }
    
    func _testOnly_unparsedKeys() -> [(key: String, value: String, type: String)] {
        self.unparsedKeys.map({ (key: $0.0.key, value: $0.0.value, type: $0.1) })
    }
#endif
}
