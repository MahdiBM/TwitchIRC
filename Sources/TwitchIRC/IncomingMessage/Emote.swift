
public struct Emote {
    /// The emote ID used in Twitch's API
    public var id = String()
    /// The emote name, which is the text used to represent the emote in a message
    public var name = String()
    /// The index in the message at which the emote starts
    public var startIndex = Int()
    /// The index in the message at which the emote ends
    public var endIndex = Int()

    public init() { }

    init(
        id: String,
        name: String,
        startIndex: Int,
        endIndex: Int
    ) {
        self.id = id
        self.name = name
        self.startIndex = startIndex
        self.endIndex = endIndex
    }

    public static func parse(from emoteString: String, and message: String) -> [Emote] {
        /// First, we need to make sure we have an homogeneous array. In the message, emotes come as
        /// a string that looks like `<id>:<start>-<end>/<id>:<start>-<end>`. However, when the same
        /// emote repeats multiple times, it's more like
        /// `<id>:<start>-<end>,<start>-<end>,<start>-<end>/<id>:<start>-<end>` and the parser has
        /// issues giving it back as a list (the parser uses commas to sepparate, and doesn't take
        /// the `/` into account).
        ///
        /// To solve this, we ask the parser to read it as a string and we treat the whole thing.
        ///
        /// Splitting by `/` returns an array like
        /// `["<id>:<start>-<end>", "<start>-<end>", "<start>-<end>", "<id>:<start>-<end>"]`,
        /// which makes it hard to treat all the elements the same since some of them have no `<id>`.
        /// We solve this by using the last seen id as the id for elements that don't have one.
        ///
        /// Ater that, it's just a matter of parsing the indices and finding the equivalent text in
        /// the chat message. With those, we can create our `EmoteReference` instance and save it.
        var parsed: [Emote] = []

        let emoteArray = emoteString.split(separator: "/")
            .flatMap { $0.split(separator: ",") }
            .map { String($0) }

        var lastID: String? = nil
        for emote in emoteArray {
            /// This gives us either `["<id>", "<start>", "<end>"]` or `["<start>", "<end>"]`
            var parts = emote.split(separator: ":")
                .flatMap { $0.split(separator: "-") }
                .map { String($0) }

            /// If we have an id, save it
            if parts.count == 3 {
                lastID = parts.removeFirst()
            }

            /// Try and retrieve the parts and add them to our list of emotes
            if let lastID = lastID,
                let startIndex = Int(parts[0]),
                let endIndex = Int(parts[1]),
                let name = message[stringIn: startIndex...endIndex]
            {
                parsed.append(.init(
                    id: lastID,
                    name: name,
                    startIndex: startIndex,
                    endIndex: endIndex
                ))
            }
        }

        return parsed
    }
}

extension String {
    /// Subscripts a string using integers to create the equivalent indices.
    subscript(stringIn range: ClosedRange<Int>) -> String? {
        guard
            let start = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let end = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex)
        else { return nil }

        return String(self[start...end])
    }
}

// MARK: - Sendable conformances
#if swift(>=5.5)
extension Emote: Sendable { }
#endif
