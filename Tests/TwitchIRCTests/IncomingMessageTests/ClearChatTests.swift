@testable import TwitchIRC
import XCTest

final class ClearChatTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":tmi.twitch.tv CLEARCHAT #dallas"
        let cc: ClearChat = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cc.channel, "dallas")
        XCTAssertEqual(cc.userLogin, nil)
        XCTAssertEqual(cc.banDuration, nil)
        XCTAssertEqual(cc.userIsPermanentlyBanned, false)
    }
    
    func testParsedValues2() throws {
        let string = ":tmi.twitch.tv CLEARCHAT #dallas :ronni"
        let cc: ClearChat = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cc.channel, "dallas")
        XCTAssertEqual(cc.userLogin, "ronni")
        XCTAssertEqual(cc.banDuration, nil)
        XCTAssertEqual(cc.userIsPermanentlyBanned, true)
    }
    
    func testParsedValues3() throws {
        let string = "@ban-duration=3600 :tmi.twitch.tv CLEARCHAT #goodvibes :toxicity"
        let cc: ClearChat = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cc.channel, "goodvibes")
        XCTAssertEqual(cc.userLogin, "toxicity")
        XCTAssertEqual(cc.banDuration, 3600)
        XCTAssertEqual(cc.userIsPermanentlyBanned, false)
    }
}
