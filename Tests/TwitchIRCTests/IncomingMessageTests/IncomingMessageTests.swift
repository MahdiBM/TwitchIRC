@testable import TwitchIRC
import XCTest

final class IncomingMessageTests: XCTestCase {
    
    private let terminator = "\r\n"
    
    func testParsingSingleMessage() throws {
        let output = ":ronni!ronni@ronni.tmi.twitch.tv JOIN #dallas"
        let messages = IncomingMessage.parse(ircOutput: output)
        
        XCTAssertEqual(messages.count, 1)
        let first = try XCTUnwrap(messages.first)
        
        XCTAssertEqual(first.text, output)
        switch first.message {
        case .join:
            break
        default:
            XCTFail("Expected `IncomingMessage.join`, found \(first)")
        }
    }
    
    func testParsingSingleMessageWithTerminator() throws {
        let rawText = "@msg-id=slow_off :tmi.twitch.tv NOTICE #dallas :This room is no longer in slow mode."
        let output = rawText + terminator
        let messages = IncomingMessage.parse(ircOutput: output)
        
        XCTAssertEqual(messages.count, 1)
        let first = try XCTUnwrap(messages.first)
        
        XCTAssertEqual(first.text, rawText)
        switch first.message {
        case .notice:
            break
        default:
            XCTFail("Expected `IncomingMessage.notice`, found \(first)")
        }
    }
    
    func testParsingSingleMessageWithTerminatorBothSides() throws {
        let rawText = ":ronni!ronni@ronni.tmi.twitch.tv PART #dallas"
        let output = terminator + rawText + terminator
        let messages = IncomingMessage.parse(ircOutput: output)
        
        XCTAssertEqual(messages.count, 1)
        let first = try XCTUnwrap(messages.first)
        
        XCTAssertEqual(first.text, rawText)
        switch first.message {
        case .part:
            break
        default:
            XCTFail("Expected `IncomingMessage.part`, found \(first)")
        }
    }
    
    func testParsingMultipleMessages() throws {
        let rawTexts = [
            "@badge-info=;badges=moderator/1;client-nonce=00e8c3279eebbb43ad80273324e10d28;color=#1E90FF;display-name=MahdiMMBM;emotes=;first-msg=0;flags=;id=7fd9a2fa-d537-4a31-b847-7e081c4c088d;mod=1;reply-parent-display-name=jay_999666;reply-parent-msg-body=!gc;reply-parent-msg-id=92d75439-9bfa-42d2-b20c-7dc4a2c07f6b;reply-parent-user-id=621834053;reply-parent-user-login=jay_999666;room-id=751562865;subscriber=0;tmi-sent-ts=1642084941607;turbo=0;user-id=519827148;user-type=mod :mahdimmbm!mahdimmbm@mahdimmbm.tmi.twitch.tv PRIVMSG #mohamedlightcr :@jay_999666 !gcs",
            ":tmi.twitch.tv 003 royalealchemist :This server is rather new",
            "@followers-only=10;emote-only=1;r9k=1;slow=10;subs-only=1;room-id=324 :tmi.twitch.tv ROOMSTATE #dallas"
        ]
        let output = rawTexts.joined(separator: terminator)
        var messages = IncomingMessage.parse(ircOutput: output)
        
        XCTAssertEqual(messages.count, 3)
        
        let first = messages.removeFirst()
        XCTAssertEqual(first.text, rawTexts[0])
        switch first.message {
        case .privateMessage:
            break
        default:
            XCTFail("Expected `IncomingMessage.privateMessage`, found \(first)")
        }
        
        let second = messages.removeFirst()
        XCTAssertEqual(second.text, rawTexts[1])
        switch second.message {
        case .connectionNotice:
            break
        default:
            XCTFail("Expected `IncomingMessage.connectionNotice`, found \(second)")
        }
        
        let third = messages.removeFirst()
        XCTAssertEqual(third.text, rawTexts[2])
        switch third.message {
        case .roomState:
            break
        default:
            XCTFail("Expected `IncomingMessage.roomState`, found \(third)")
        }
    }
}
