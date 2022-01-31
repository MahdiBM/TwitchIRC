@testable import TwitchIRC
import XCTest

final class OutgoingMessageTests: XCTestCase {
    
    func testPrivateMessage() throws {
        do {
            let message = OutgoingMessage.privateMessage(
                to: "mahdimmbm",
                message: "HeyGuys my dudes",
                messageIdToReply: nil
            )
            let serialized = message.serialize()
            
            XCTAssertEqual(
                serialized,
                "PRIVMSG #mahdimmbm :HeyGuys my dudes"
            )
        }
        
        do {
            let message = OutgoingMessage.privateMessage(
                to: "ronni",
                message: "HeyGuys HeyGuys",
                messageIdToReply: "b34ccfc7-4977-403a-8a94-33c6bac34fb8"
            )
            let serialized = message.serialize()
            
            XCTAssertEqual(
                serialized,
                "@reply-parent-msg-id=b34ccfc7-4977-403a-8a94-33c6bac34fb8 PRIVMSG #ronni :HeyGuys HeyGuys"
            )
        }
        
        do {
            let message = OutgoingMessage.privateMessage(
                to: "ronni",
                message: "HeyGuys HeyGuys",
                messageIdToReply: ""
            )
            let serialized = message.serialize()
            
            XCTAssertEqual(
                serialized,
                "PRIVMSG #ronni :HeyGuys HeyGuys"
            )
        }
    }
    
    func testJoin() throws {
        let message = OutgoingMessage.join(
            to: "mahdibm"
        )
        let serialized = message.serialize()
        
        XCTAssertEqual(
            serialized,
            "JOIN #mahdibm"
        )
    }
    
    func testPart() throws {
        let message = OutgoingMessage.part(
            from: "dallas"
        )
        let serialized = message.serialize()
        
        XCTAssertEqual(
            serialized,
            "PART #dallas"
        )
    }
    
    func testPass() throws {
        let message = OutgoingMessage.pass(
            pass: "SKADINSinOPDsodnoDNSDONS@W(*@H(WS(W(B*E#$&@4@(@!"
        )
        let serialized = message.serialize()
        
        XCTAssertEqual(
            serialized,
            "PASS oauth:SKADINSinOPDsodnoDNSDONS@W(*@H(WS(W(B*E#$&@4@(@!"
        )
    }
    
    func testNick() throws {
        let message = OutgoingMessage.nick(
            name: "royalealchemist"
        )
        let serialized = message.serialize()
        
        XCTAssertEqual(
            serialized,
            "NICK royalealchemist"
        )
    }
    
    func testCapabilities() throws {
        do {
            let message = OutgoingMessage.capabilities(
                [.commands, .membership]
            )
            let serialized = message.serialize()
            
            XCTAssertEqual(
                serialized,
                "CAP REQ :twitch.tv/commands twitch.tv/membership"
            )
        }
        
        do {
            let message = OutgoingMessage.capabilities(
                [.tags]
            )
            let serialized = message.serialize()
            
            XCTAssertEqual(
                serialized,
                "CAP REQ :twitch.tv/tags"
            )
        }
    }
    
    func testPing() throws {
        let message = OutgoingMessage.ping
        let serialized = message.serialize()
        
        XCTAssertEqual(
            serialized,
            "PING :tmi.twitch.tv"
        )
    }
    
    func testPong() throws {
        let message = OutgoingMessage.pong
        let serialized = message.serialize()
        
        XCTAssertEqual(
            serialized,
            "PONG :tmi.twitch.tv"
        )
    }
}
