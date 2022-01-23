@testable import TwitchIRC
import XCTest

final class NoticeTests: XCTestCase {
    
    /// Test `MessageID` cases are unique even without dashes.
    func testMessageIDCasesUnique() throws {
        let cases = Notice.MessageID.allCases.map({
            $0.rawValue.filter({ $0 != "_" })
        })
        XCTAssertEqual(cases.count, Set(cases).count)
    }
    
    /// Test `MessageID.init(rawValue:)` is dash-independent.
    func testMessageIDInitDashIndependent() throws {
        let first = try XCTUnwrap(Notice.MessageID(rawValue: "followers_onzero"))
        let second = try XCTUnwrap(Notice.MessageID(rawValue: "followers_on_zero"))
        let third = try XCTUnwrap(Notice.MessageID(rawValue: "followersonzero"))
        
        XCTAssertEqual(.followers_onzero, first)
        XCTAssertEqual(first, second)
        XCTAssertEqual(second, third)
    }
    
    func testParsedValues1() throws {
        let string = "@msg-id=slow_off :tmi.twitch.tv NOTICE #dallas :This room is no longer in slow mode."
        
        let notice: Notice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(notice.message, "This room is no longer in slow mode.")
        XCTAssertEqual(notice.channel, "dallas")
        let messageId = try XCTUnwrap(notice.messageId)
        XCTAssertEqual(messageId, .slow_off)
    }
    
    func testParsedValues2() throws {
        let string = "@msg-id=followers_on_zero :tmi.twitch.tv NOTICE #simonpetrik :This room is now in followers-only mode."
        
        let notice: Notice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(notice.message, "This room is now in followers-only mode.")
        XCTAssertEqual(notice.channel, "simonpetrik")
        let messageId = try XCTUnwrap(notice.messageId)
        XCTAssertEqual(messageId, .followers_onzero)
    }
}
