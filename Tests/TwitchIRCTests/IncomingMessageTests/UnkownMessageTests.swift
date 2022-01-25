@testable import TwitchIRC
import XCTest

final class UnknownMessageTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = "noiadsonsdmsdada msp mdapfmadfo nadofnskm"
        let messages = IncomingMessage.parse(ircOutput: string)
        
        XCTAssertEqual(messages.count, 1)
        let first = try XCTUnwrap(messages.first)
        XCTAssertTrue(first.message == nil)
        XCTAssertEqual(first.text, string)
    }
    
    func testParsedValues2() throws {
        let string = ":ronni!ronni@ronni.tmi.twitch.tv PARTI #dallas"
        let messages = IncomingMessage.parse(ircOutput: string)
        
        XCTAssertEqual(messages.count, 1)
        let first = try XCTUnwrap(messages.first)
        XCTAssertTrue(first.message == nil)
        XCTAssertEqual(first.text, string)
    }
    
    func testParsedValues3() throws {
        let string = ":ronni!ronni@ronni.tmi.twitch.tv AJOIN #dallas"
        let messages = IncomingMessage.parse(ircOutput: string)
        
        XCTAssertEqual(messages.count, 1)
        let first = try XCTUnwrap(messages.first)
        XCTAssertTrue(first.message == nil)
        XCTAssertEqual(first.text, string)
    }
    
    func testParsedValues4() throws {
        let string = "@msg-id=slow_off :tmi.twitch.tv OTICE #dallas :This room is no longer in slow mode."
        let messages = IncomingMessage.parse(ircOutput: string)
        
        XCTAssertEqual(messages.count, 1)
        let first = try XCTUnwrap(messages.first)
        XCTAssertTrue(first.message == nil)
        XCTAssertEqual(first.text, string)
    }
    
    func testParsedValues5() throws {
        let string = "@login=ronni;target-msg-id=abc-123-def;room-id=;tmi-sent-ts=1642860513538 :tmi.twitch.tv CLEARMS #dallas :HeyGuys"
        let messages = IncomingMessage.parse(ircOutput: string)
        
        XCTAssertEqual(messages.count, 1)
        let first = try XCTUnwrap(messages.first)
        XCTAssertTrue(first.message == nil)
        XCTAssertEqual(first.text, string)
    }
}
