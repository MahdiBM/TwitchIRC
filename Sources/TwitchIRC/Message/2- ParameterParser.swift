
/// Parses parameters from Twitch-sent values.
struct ParameterParser {
    
    private typealias StoredElement = (offset: Int, element: (key: String, value: String))
    
    /// The storage of the values.
    private let storage: [StoredElement]
    /// Indices of the used storage elements.
    private var usedIndices = [Int]()
    /// Keys that were unavailable.
    private var unavailableKeys = [String]()
    
    init(_ input: String) {
        let values = input.components(separatedBy: ";").compactMap {
            $0.componentsOneSplit(separatedBy: "=").map({ (key: $0.lhs, value: $0.rhs) })
        }
        self.storage = .init(values.enumerated())
    }
    
    func getUnknownElements(excludedKeys: [String] = []) -> [(key: String, value: String)] {
        self.storage.filter({
            !usedIndices.contains($0.offset)
            && !excludedKeys.contains($0.element.key)
        }).map(\.element)
    }
    
    func getUnavailableKeys(excludedKeys: [String] = []) -> [String] {
        self.unavailableKeys.filter({ !excludedKeys.contains($0) })
    }
    
    private mutating func get(for key: String) -> StoredElement? {
        if let stored = storage.first(where: { $0.element.key == key }) {
            return stored
        } else {
            self.unavailableKeys.append(key)
            return nil
        }
    }
    
    mutating func optionalString(for key: String) -> String? {
        if let stored = self.get(for: key) {
            self.usedIndices.append(stored.offset)
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
        if let stored = self.get(for: key),
           let uint = UInt(stored.element.value) {
            self.usedIndices.append(stored.offset)
            return uint
        } else {
            return nil
        }
    }
    
    mutating func uint(for key: String) -> UInt {
        self.optionalUInt(for: key) ?? 0
    }
    
    mutating func optionalBool(for key: String) -> Bool? {
        if let stored = self.get(for: key) {
            let value = stored.element.value
            if value == "1" {
                self.usedIndices.append(stored.offset)
                return true
            } else if value == "0" {
                self.usedIndices.append(stored.offset)
                return false
            } else {
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
        if let stored = self.get(for: key),
           let representable = R.init(rawValue: stored.element.value) {
            self.usedIndices.append(stored.offset)
            return representable
        } else {
            return nil
        }
    }
}
