@testable import TwitchIRC
import XCTest

enum TestUtils {
    
    /// Unwraps first of the messages into an expected type.
    static func parseAndUnwrap<T>(
        string: String,
        as type: T.Type = T.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T {
        let messages = Message.parse(ircOutput: string)
        XCTAssertEqual(messages.count, 1, "Message count expected to be 1: \(messages)", file: file, line: line)
        let value = try XCTUnwrap(messages.first?.anyValue as? T, "Message type not expected. Available value: \(messages.first?.anyValue ?? "NULL"), Expected type: \(T.self)", file: file, line: line)
        return value
    }
    
}

private extension Message {
    var anyValue: Any {
        switch self {
        case .connectionNotice(let connectionNotice):
            return connectionNotice
        case .channelEntrance(let channelEntrance):
            return channelEntrance
        case .globalUserState(let globalUserState):
            return globalUserState
        case .privateMessage(let privateMessage):
            return privateMessage
        case .join(let join):
            return join
        case .part(let part):
            return part
        case .clearChat(let clearChat):
            return clearChat
        case .clearMessage(let clearMessage):
            return clearMessage
        case .hostTarget(let hostTarget):
            return hostTarget
        case .notice(let notice):
            return notice
        case .reconnect:
            return ()
        case .roomState(let roomState):
            return roomState
        case .userNotice(let userNotice):
            return userNotice
        case .userState(let userState):
            return userState
        case .capabilities(let capabilities):
            return capabilities
        case .whisper(let whisper):
            return whisper
        case .ping:
            return ()
        case .pong:
            return ()
        case .unknown(let message):
            return message
        }
    }
}
