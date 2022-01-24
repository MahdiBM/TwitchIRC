
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
    private var unparsedKeys = [(key: String, type: String)]()
    
    init(_ input: String) {
        let values = input.components(separatedBy: ";").compactMap {
            $0.componentsOneSplit(separatedBy: "=").map({ (key: $0.lhs, value: $0.rhs) })
        }
        self.storage = .init(values.enumerated())
    }
    
    func getLeftOvers(
        excludedUnusedKeys: [String] = [],
        excludedUnavailableKeys: [String] = []
    ) -> ParsingLeftOvers {
        let unusedPairs = self.storage.filter({
            !(self.usedIndices.contains($0.offset) || excludedUnusedKeys.contains($0.element.key))
        }).map({ ParsingLeftOvers.UnusedPair(key: $0.element.key, value: $0.element.value) })
        let unavailableKeys = self.unavailableKeys
            .filter({ !excludedUnavailableKeys.contains($0) })
        let unparsedKeys = unparsedKeys.map {
            ParsingLeftOvers.UnparsedKey(key: $0.key, type: $0.type)
        }
        return ParsingLeftOvers(
            unusedPairs: unusedPairs,
            unavailableKeys: unavailableKeys,
            unparsedKeys: unparsedKeys
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
    
    private mutating func appendUnparsedKey<T>(key: String, type: T.Type) {
        self.unparsedKeys.append((key: key, type: String(describing: type)))
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
            return value.components(separatedBy: ",").filter({ !$0.isEmpty })
        } else {
            return []
        }
    }
    
    mutating func optionalUInt(for key: String) -> UInt? {
        if let stored = self.get(for: key) {
            if let uint = UInt(stored.element.value) {
                return uint
            } else {
               self.appendUnparsedKey(key: key, type: UInt.self)
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
                self.appendUnparsedKey(key: key, type: Int.self)
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
                self.appendUnparsedKey(key: key, type: Bool.self)
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
                self.appendUnparsedKey(key: key, type: R.self)
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
    
    func _testOnly_unparsedKeys() -> [(key: String, type: String)] {
        self.unparsedKeys
    }
#endif
}
