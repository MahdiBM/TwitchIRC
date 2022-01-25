@testable import TwitchIRC
import XCTest

final class ConnectionNoticeTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":tmi.twitch.tv 001 royalealchemist :Welcome, GLHF!"
        let cn: ConnectionNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cn.message, "Welcome, GLHF!")
        XCTAssertEqual(cn.userLogin, "royalealchemist")
        XCTAssertEqual(cn.number, 1)
    }
    
    func testParsedValues2() throws {
        let string = ":tmi.twitch.tv 002 royalealchemist :Your host is tmi.twitch.tv"
        let cn: ConnectionNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cn.message, "Your host is tmi.twitch.tv")
        XCTAssertEqual(cn.userLogin, "royalealchemist")
        XCTAssertEqual(cn.number, 2)
    }
    
    func testParsedValues3() throws {
        let string = ":tmi.twitch.tv 003 royalealchemist :This server is rather new"
        let cn: ConnectionNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cn.message, "This server is rather new")
        XCTAssertEqual(cn.userLogin, "royalealchemist")
        XCTAssertEqual(cn.number, 3)
    }
    
    func testParsedValues4() throws {
        let string = ":tmi.twitch.tv 004 royalealchemist :-"
        let cn: ConnectionNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cn.message, "-")
        XCTAssertEqual(cn.userLogin, "royalealchemist")
        XCTAssertEqual(cn.number, 4)
    }
    
    func testParsedValues5() throws {
        let string = ":tmi.twitch.tv 375 royalealchemist :-"
        let cn: ConnectionNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cn.message, "-")
        XCTAssertEqual(cn.userLogin, "royalealchemist")
        XCTAssertEqual(cn.number, 375)
    }
    
    func testParsedValues6() throws {
        let string = ":tmi.twitch.tv 372 royalealchemist :You are in a maze of twisty passages, all alike."
        let cn: ConnectionNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cn.message, "You are in a maze of twisty passages, all alike.")
        XCTAssertEqual(cn.userLogin, "royalealchemist")
        XCTAssertEqual(cn.number, 372)
    }
    
    func testParsedValues7() throws {
        let string = ":tmi.twitch.tv 376 royalealchemist :>"
        let cn: ConnectionNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cn.message, ">")
        XCTAssertEqual(cn.userLogin, "royalealchemist")
        XCTAssertEqual(cn.number, 376)
    }
}
