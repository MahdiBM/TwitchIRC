@testable import TwitchIRC
import XCTest

final class NoticeTests: XCTestCase {
    
    /// Test `MessageID.init(rawValue:)` is dash-independent.
    func testMessageIDInitDashIndependent() throws {
        let first = try XCTUnwrap(Notice.MessageID(rawValue: "followers_onzero"))
        let second = try XCTUnwrap(Notice.MessageID(rawValue: "followers_on_zero"))
        let third = try XCTUnwrap(Notice.MessageID(rawValue: "followersonzero"))
        
        XCTAssertEqual(.followersOnZero, first)
        XCTAssertEqual(first, second)
        XCTAssertEqual(second, third)
    }
    
    func testParsedValues1() throws {
        let string = "@msg-id=slow_off :tmi.twitch.tv NOTICE #dallas :This room is no longer in slow mode."
        
        let notice: Notice = try TestUtils.parseAndUnwrap(string: string)
        
        switch notice.kind {
        case let .local(channel, message, messageId):
            XCTAssertEqual(message, "This room is no longer in slow mode.")
            XCTAssertEqual(channel, "dallas")
            XCTAssertEqual(messageId, .slowOff)
        default:
            XCTFail("Unexpected noice kind. Expected `Kind.local`, found \(notice.kind!)")
        }
    }
    
    func testParsedValues2() throws {
        let string = "@msg-id=followers_on_zero :tmi.twitch.tv NOTICE #simonpetrik :This room is now in followers-only mode."
        
        let notice: Notice = try TestUtils.parseAndUnwrap(string: string)
        
        switch notice.kind {
        case let .local(channel, message, messageId):
            XCTAssertEqual(message, "This room is now in followers-only mode.")
            XCTAssertEqual(channel, "simonpetrik")
            XCTAssertEqual(messageId, .followersOnZero)
        default:
            XCTFail("Unexpected noice kind. Expected `Kind.local`, found \(notice.kind!)")
        }
    }
    
    func testParsedValues3() throws {
        let string = ":tmi.twitch.tv NOTICE * :Login authentication failed"
        let notice: Notice = try TestUtils.parseAndUnwrap(string: string)
        
        switch notice.kind {
        case let .global(message):
            XCTAssertEqual(message, "Login authentication failed")
        default:
            XCTFail("Unexpected noice kind. Expected `Kind.global`, found \(notice.kind!)")
        }
    }
    
    func testParsedValues4() throws {
        let string = ":tmi.twitch.tv NOTICE * :Login unsuccessful"
        let notice: Notice = try TestUtils.parseAndUnwrap(string: string)
        
        switch notice.kind {
        case let .global(message):
            XCTAssertEqual(message, "Login unsuccessful")
        default:
            XCTFail("Unexpected noice kind. Expected `Kind.global`, found \(notice.kind!)")
        }
    }
}
