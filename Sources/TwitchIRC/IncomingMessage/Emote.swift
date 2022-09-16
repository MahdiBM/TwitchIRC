
public struct Emote {
    /// The emote ID used in Twitch's API
    public var id = String()
    /// The emote name, which is the text used to represent the emote in a message
    public var name = String()
    /// The index in the message at which the emote starts
    public var startIndex = Int()
    /// The index in the message at which the emote ends
    public var endIndex = Int()
    /// Whether this is an animated emote
    public var isAnimated = Bool()

    public init() { }

    init(
        id: String,
        name: String,
        startIndex: Int,
        endIndex: Int,
        isAnimated: Bool
    ) {
        self.id = id
        self.name = name
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.isAnimated = isAnimated
    }

    static func parse(from emoteString: String, and message: String) -> [Emote] {
        let message = message.unicodeScalars
        var parsed = [Emote]()
        
        for emotes in emoteString.split(separator: "/") {
            let split = emotes.split(separator: ":")
            guard split.count == 2 else { continue }
            let id = String(split[0])
            let isAnimated = id.hasPrefix("emotesv2_")
            for rangeString in split[1].split(separator: ",") {
                let ranges = rangeString.split(separator: "-")
                guard ranges.count == 2,
                      let lowerBound = Int(String(ranges[0])),
                      let upperBound = Int(String(ranges[1])),
                      let name = message[stringIn: lowerBound...upperBound]
                else { continue }
                parsed.append(.init(
                    id: id,
                    name: name,
                    startIndex: lowerBound,
                    endIndex: upperBound,
                    isAnimated: isAnimated
                ))
            }
        }

        return parsed
    }
}

private extension String.UnicodeScalarView {
    /// Subscripts a string using integers to create the equivalent indices.
    subscript(stringIn range: ClosedRange<Int>) -> String? {
        guard let start = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
              let end = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex)
        else { return nil }
        
        return String(self[start...end])
    }
}

// MARK: - Sendable conformances
#if swift(>=5.5)
extension Emote: Sendable { }
#endif
