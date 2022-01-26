@testable import TwitchIRC
import XCTest

final class UnknownCommandTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":tmi.twitch.tv 421 royalealchemist PRIVSG :Unknown command"
        let unknownCommand: UnknownCommand = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(unknownCommand.username, "royalealchemist")
        XCTAssertEqual(unknownCommand.command, "PRIVSG")
        XCTAssertEqual(unknownCommand.message, "Unknown command")
    }
    
    func testParsedValues2() throws {
        let string = ":tmi.twitch.tv 421 mahdimmbm WHISP :Unknown command"
        let unknownCommand: UnknownCommand = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(unknownCommand.username, "mahdimmbm")
        XCTAssertEqual(unknownCommand.command, "WHISP")
        XCTAssertEqual(unknownCommand.message, "Unknown command")
    }
}
