@testable import TwitchIRC
import XCTest

final class ParametersParserTests: XCTestCase {
    
    func testEmptyLeftOvers1() throws {
        let params = "badge-info=;badges=moderator/1;client-nonce=00e8c3279eebbb43ad80273324e10d28;color=#1E90FF;display-name=MahdiMMBM;emotes=;first-msg=0;flags=;id=7fd9a2fa-d537-4a31-b847-7e081c4c088d;mod=1;reply-parent-display-name=jay_999666;reply-parent-msg-body=!gc;reply-parent-msg-id=92d75439-9bfa-42d2-b20c-7dc4a2c07f6b;reply-parent-user-id=621834053;reply-parent-user-login=jay_999666;room-id=751562865;subscriber=0;tmi-sent-ts=1642084941607;turbo=0;user-id=519827148;user-type=mod"
        
        var parser = ParametersParser(params)
        
        /// Test private properties after initialization.
        XCTAssertEqual(parser._testOnly_storage().count, 21)
        XCTAssertEqual(parser._testOnly_usedIndices(), [])
        XCTAssertEqual(parser._testOnly_unavailableKeys(), [])
        XCTAssertTrue(parser._testOnly_unparsedKeys().isEmpty)
        
        /// Testing normal parsing activity.
        XCTAssertEqual(parser.array(for: "badge-info"), [])
        XCTAssertEqual(parser.array(for: "badges"), ["moderator/1"])
        XCTAssertEqual(parser.string(for: "client-nonce"), "00e8c3279eebbb43ad80273324e10d28")
        XCTAssertEqual(parser.string(for: "color"), "#1E90FF")
        XCTAssertEqual(parser.string(for: "display-name"), "MahdiMMBM")
        XCTAssertEqual(parser.array(for: "emotes"), [])
        /// Here we skipped `first-msg` and `flags`
        /// which must have had indices of `6` and `7` in parser's `storage`.
        XCTAssertEqual(parser.string(for: "id"), "7fd9a2fa-d537-4a31-b847-7e081c4c088d")
        
        /// Test private properties in the middle of process.
        /// Not a real-world use, just to test.
        XCTAssertEqual(parser._testOnly_storage().count, 21)
        XCTAssertEqual(parser._testOnly_usedIndices().sorted(), [0, 1, 2, 3, 4, 5, 8])
        XCTAssertEqual(parser._testOnly_unavailableKeys(), [])
        XCTAssertTrue(parser._testOnly_unparsedKeys().isEmpty)
        
        /// There is no such key as `limit` or `prize`.
        /// The keys `limit` and `prize` must get added to `unavailableKeys` after this.
        XCTAssertEqual(parser.optionalString(for: "limit"), nil)
        XCTAssertEqual(parser.optionalString(for: "prize"), nil)
        
        /// Testing `unavailableKeys` for existence of `limit` and `prize`.
        XCTAssertEqual(parser._testOnly_storage().count, 21)
        XCTAssertEqual(parser._testOnly_usedIndices().sorted(), [0, 1, 2, 3, 4, 5, 8])
        XCTAssertEqual(parser._testOnly_unavailableKeys(), ["limit", "prize"])
        XCTAssertTrue(parser._testOnly_unparsedKeys().isEmpty)
        
        /// `reply-parent-msg-id` is equal to `92d75439-9bfa-42d2-b20c-7dc4a2c07f6b`
        /// so trying to get it as an `UInt` must fail.
        XCTAssertEqual(parser.optionalUInt(for: "reply-parent-msg-id"), nil)
        /// `reply-parent-user-login` is equal to `jay_999666`
        /// so trying to get it as an `Int` must fail.
        XCTAssertEqual(parser.optionalInt(for: "reply-parent-user-login"), nil)
        /// `room-id` is equal to `751562865`
        /// so trying to get it as a `Bool` must fail.
        XCTAssertEqual(parser.optionalBool(for: "room-id"), nil)
        /// `user-type` is equal to `mod`
        /// so trying to get it as any Representable type like `SubPlan` must fail.
        XCTAssertEqual(
            parser.representable(for: "user-type", as: UserNotice.MessageID.SubPlan.self),
            nil
        )
        /// There is no such key as `non-existent-key`
        /// so trying to get it as a `Bool` must fail.
        /// This, unlike the 4-above, will not add any integers to `usedIndices`.
        XCTAssertEqual(parser.optionalBool(for: "non-existent-key"), nil)
        
        /// Testing `unparsedKeys` for existence of
        /// `reply-parent-msg-id`, `reply-parent-user-login`,
        /// `room-id`, `user-type` and `non-existent-key`
        /// alongside the types they were tried to be parsed into.
        XCTAssertEqual(parser._testOnly_storage().count, 21)
        /// The indices of the keys must have been added to `usedIndices` as well, if they existed.
        XCTAssertEqual(
            parser._testOnly_usedIndices().sorted(),
            [0, 1, 2, 3, 4, 5, 8, 12, 14, 15, 20]
        )
        /// `non-existent-key` must have been added to `unavailableKeys` too.
        XCTAssertEqual(
            parser._testOnly_unavailableKeys(),
            ["limit", "prize", "non-existent-key"]
        )
        XCTAssertEqual(
            parser._testOnly_unparsedKeys().debugDescription,
            [(key: String, type: String)]([
                (key: "reply-parent-msg-id", type: "UInt"),
                (key: "reply-parent-user-login", type: "Int"),
                (key: "room-id", type: "Bool"),
                (key: "user-type", type: "SubPlan")
            ]).debugDescription
        )
        
        /// Testing ParsingLeftOvers
        
        let leftOvers = parser.getLeftOvers()
        
        typealias UnusedPair = ParsingLeftOvers.UnusedPair
        XCTAssertEqual(
            leftOvers.unusedPairs.debugDescription,
            [
                UnusedPair(key: "first-msg", value: "0"),
                UnusedPair(key: "flags", value: ""),
                UnusedPair(key: "mod", value: "1"),
                UnusedPair(key: "reply-parent-display-name", value: "jay_999666"),
                UnusedPair(key: "reply-parent-msg-body", value: "!gc"),
                UnusedPair(key: "reply-parent-user-id", value: "621834053"),
                UnusedPair(key: "subscriber", value: "0"),
                UnusedPair(key: "tmi-sent-ts", value: "1642084941607"),
                UnusedPair(key: "turbo", value: "0"),
                UnusedPair(key: "user-id", value: "519827148")
            ].debugDescription
        )
        XCTAssertEqual(
            leftOvers.unavailableKeys,
            ["limit", "prize", "non-existent-key"]
        )
        typealias UnparsedKey = ParsingLeftOvers.UnparsedKey
        XCTAssertEqual(
            leftOvers.unparsedKeys.debugDescription,
            [
                UnparsedKey(key: "reply-parent-msg-id", type: "UInt"),
                UnparsedKey(key: "reply-parent-user-login", type: "Int"),
                UnparsedKey(key: "room-id", type: "Bool"),
                UnparsedKey(key: "user-type", type: "SubPlan")
            ].debugDescription
        )
        XCTAssertEqual(leftOvers.isEmpty, false)
    }
    
    func testParsingLeftOversIsEmpty() throws {
        let emptyLeftOvers = ParsingLeftOvers()
        XCTAssertEqual(emptyLeftOvers.isEmpty, true)
    }
    
    func testParsingLeftOversValuesWithParameterParserWithGroupedUnavailableKeys1() throws {
        let params = "badge-info=;badges=moderator/1;color=#1E90FF;display-name=MahdiMMBM;emotes=;first-msg=0;flags=;id=7fd9a2fa-d537-4a31-b847-7e081c4c088d;reply-parent-display-name=jay_999666;reply-parent-msg-body=!gc;reply-parent-msg-id=92d75439-9bfa-42d2-b20c-7dc4a2c07f6b;reply-parent-user-id=621834053;reply-parent-user-login=jay_999666;room-id=751562865;subscriber=0;tmi-sent-ts=1642084941607;turbo=0;user-id=519827148;user-type=mod"
        
        var parser = ParametersParser(params)
        
        XCTAssertNotEqual(parser.optionalString(for: "reply-parent-display-name"), nil)
        XCTAssertNotEqual(parser.optionalString(for: "reply-parent-user-login"), nil)
        XCTAssertNotEqual(parser.optionalString(for: "reply-parent-msg-body"), nil)
        XCTAssertNotEqual(parser.optionalString(for: "reply-parent-msg-id"), nil)
        XCTAssertNotEqual(parser.optionalString(for: "reply-parent-user-id"), nil)
        
        XCTAssertEqual(parser._testOnly_storage().count, 19)
        XCTAssertEqual(
            parser._testOnly_usedIndices().sorted(),
            [8, 9, 10, 11, 12]
        )
        XCTAssertEqual(parser._testOnly_unavailableKeys(), [])
        XCTAssertTrue(parser._testOnly_unparsedKeys().isEmpty)
        
        let occasionalKeys = [["first-msg"], ["reply-parent-display-name", "reply-parent-user-login", "reply-parent-msg-body", "reply-parent-msg-id", "reply-parent-user-id"]]
        let leftOvers = parser.getLeftOvers(groupsOfExcludedUnavailableKeys: occasionalKeys)
        
        /// All `reply-parent-*` keys are available in the parameters.
        /// Based on `occasionalKeys` groupings `leftOvers.unavailableKeys` must
        /// contain none of those keys.
        XCTAssertEqual(leftOvers.unavailableKeys, [])
    }
    
    func testParsingLeftOversValuesWithParameterParserWithGroupedUnavailableKeys2() throws {
        let params = "badge-info=;badges=moderator/1;color=#1E90FF;display-name=MahdiMMBM;emotes=;first-msg=0;flags=;id=7fd9a2fa-d537-4a31-b847-7e081c4c088d;reply-parent-display-name=jay_999666;reply-parent-msg-id=92d75439-9bfa-42d2-b20c-7dc4a2c07f6b;reply-parent-user-id=621834053;room-id=751562865;subscriber=0;tmi-sent-ts=1642084941607;turbo=0;user-id=519827148;user-type=mod"
        
        var parser = ParametersParser(params)
        
        XCTAssertNotEqual(parser.optionalString(for: "reply-parent-display-name"), nil)
        XCTAssertEqual(parser.optionalString(for: "reply-parent-user-login"), nil)
        XCTAssertEqual(parser.optionalString(for: "reply-parent-msg-body"), nil)
        XCTAssertNotEqual(parser.optionalString(for: "reply-parent-msg-id"), nil)
        XCTAssertNotEqual(parser.optionalString(for: "reply-parent-user-id"), nil)
        
        XCTAssertEqual(parser._testOnly_storage().count, 17)
        XCTAssertEqual(
            parser._testOnly_usedIndices().sorted(),
            [8, 9, 10]
        )
        XCTAssertEqual(
            parser._testOnly_unavailableKeys(),
            ["reply-parent-user-login", "reply-parent-msg-body"]
        )
        XCTAssertTrue(parser._testOnly_unparsedKeys().isEmpty)
        
        let replyKeys = ["reply-parent-display-name", "reply-parent-user-login", "reply-parent-msg-body", "reply-parent-msg-id", "reply-parent-user-id"]
        let occasionalKeys = [["first-msg"], replyKeys]
        let leftOvers = parser.getLeftOvers(groupsOfExcludedUnavailableKeys: occasionalKeys)
        
        /// Some `reply-parent-*` keys are present in the parameters and some are not.
        /// Based on `occasionalKeys` groupings `leftOvers.unavailableKeys` must
        /// contain all of the unavailable keys. It is expected all or no key of `replyKeys`
        /// be available in the `parser.unavailableKeys` or otherwise `leftOvers.unavailableKeys`
        /// must contain all unavailable keys and ignore the excluded-filters.
        XCTAssertEqual(
            leftOvers.unavailableKeys,
            ["reply-parent-user-login", "reply-parent-msg-body"]
        )
    }
    
    func testParsingLeftOversValuesWithParameterParserWithGroupedUnavailableKeys3() throws {
        let params = "badge-info=;badges=moderator/1;color=#1E90FF;display-name=MahdiMMBM;emotes=;flags=;id=7fd9a2fa-d537-4a31-b847-7e081c4c088d;room-id=751562865;subscriber=0;tmi-sent-ts=1642084941607;turbo=0;user-id=519827148;user-type=mod"
        
        var parser = ParametersParser(params)
        
        XCTAssertEqual(parser.optionalString(for: "reply-parent-display-name"), nil)
        XCTAssertEqual(parser.optionalString(for: "reply-parent-user-login"), nil)
        XCTAssertEqual(parser.optionalString(for: "reply-parent-msg-body"), nil)
        XCTAssertEqual(parser.optionalString(for: "reply-parent-msg-id"), nil)
        XCTAssertEqual(parser.optionalString(for: "reply-parent-user-id"), nil)
        
        XCTAssertEqual(parser.optionalString(for: "first-msg"), nil)
        
        XCTAssertEqual(parser._testOnly_storage().count, 13)
        XCTAssertEqual(parser._testOnly_usedIndices().sorted(), [])
        XCTAssertEqual(
            parser._testOnly_unavailableKeys(),
            ["reply-parent-display-name", "reply-parent-user-login", "reply-parent-msg-body", "reply-parent-msg-id", "reply-parent-user-id", "first-msg"]
        )
        XCTAssertTrue(parser._testOnly_unparsedKeys().isEmpty)
        
        do {
            let occasionalKeys = [["first-msg"], ["reply-parent-display-name", "reply-parent-user-login", "reply-parent-msg-body", "reply-parent-msg-id", "reply-parent-user-id"]]
            let leftOvers = parser.getLeftOvers(groupsOfExcludedUnavailableKeys: occasionalKeys)
            
            /// No `reply-parent-*` key is available in the parameters.
            /// Based on `occasionalKeys` groupings `leftOvers.unavailableKeys` must
            /// contain none of those keys.
            XCTAssertEqual(leftOvers.unavailableKeys, [])
        }
        
        do {
            let occasionalKeys = [["reply-parent-display-name", "reply-parent-user-login", "reply-parent-msg-body", "reply-parent-msg-id", "reply-parent-user-id"]]
            let leftOvers = parser.getLeftOvers(groupsOfExcludedUnavailableKeys: occasionalKeys)
            
            ///
            XCTAssertEqual(leftOvers.unavailableKeys, ["first-msg"])
        }
    }
}
