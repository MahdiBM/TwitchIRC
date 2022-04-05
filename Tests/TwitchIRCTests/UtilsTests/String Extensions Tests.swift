@testable import TwitchIRC
import XCTest

final class StringExtensionTests: XCTestCase {
    
    func testComponentsSeparatedBy() throws {
        
        try componentsSeparatedByTester(mode: .string)
        
        try componentsSeparatedByTester(mode: .substring)
    }
    
    func testComponentsOneSplit() throws {
        
        try componentsOneSplitTester(mode: .string)
        
        try componentsOneSplitTester(mode: .substring)
    }
    
    func componentsSeparatedByTester(mode: Mode) throws {
        
        func separateComponents(_ string: String, by separator: String) -> [String] {
            switch getStringProtocol(from: string, mode: mode) {
            case let .string(string):
                return string.componentsSeparatedBy(separator: separator)
            case let .substring(substring):
                return substring.componentsSeparatedBy(separator: separator).map(String.init)
            }
        }
        
        // Testing normal usage
        do {
            let separated = separateComponents("Hello my dear.", by: "my")
            XCTAssertEqual(separated, ["Hello ", " dear."])
        }
        
        // Testing separator at the end
        do {
            let separated = separateComponents("Hello my dear.", by: "dear.")
            XCTAssertEqual(separated, ["Hello my ", ""])
        }
        
        // Testing separator at the beginning
        do {
            let separated = separateComponents("Hello my dear.", by: "Hell")
            XCTAssertEqual(separated, ["", "o my dear."])
        }
        
        // Testing only one letter
        do {
            let separated = separateComponents("Hello my dear.", by: "m")
            XCTAssertEqual(separated, ["Hello ", "y dear."])
        }
        
        // Testing only one letter at the end
        do {
            let separated = separateComponents("Hello my dear.", by: ".")
            XCTAssertEqual(separated, ["Hello my dear", ""])
        }
        
        // Testing multiple matching cases
        do {
            let separated = separateComponents("Hello my dear dear.", by: "dear")
            XCTAssertEqual(separated, ["Hello my ", " ", "."])
        }
        
        // Testing multiple matching cases 2
        do {
            let separated = separateComponents("dear Hello my deardear", by: "dear")
            XCTAssertEqual(separated, ["", " Hello my ", "", ""])
        }
        
        // Testing half-overlapping cases
        do {
            let separated = separateComponents("dedear", by: "dear")
            XCTAssertEqual(separated, ["de", ""])
        }
        
        // Testing half-overlapping cases 2
        do {
            let separated = separateComponents("uretmi.tmi.twitch.tv PRIVMSG", by: "tmi.twitch.tv")
            XCTAssertEqual(separated, ["uretmi.", " PRIVMSG"])
        }
        
        // Testing very similar matching cases
        do {
            let separated = separateComponents("Hello my dear dear.", by: "dear.")
            XCTAssertEqual(separated, ["Hello my dear ", ""])
        }
        
        // Testing a string split by itself
        do {
            let separated = separateComponents("dear", by: "dear")
            XCTAssertEqual(separated, ["", ""])
        }
        
        // Testing 2x(a string) split by itself
        do {
            let separated = separateComponents("deardear", by: "dear")
            XCTAssertEqual(separated, ["", "", ""])
        }
        
        // Testing no matching cases
        do {
            let separated = separateComponents("Hello my dear dear.", by: "dearr")
            XCTAssertEqual(separated, ["Hello my dear dear."])
        }
        
        // Testing no matching cases at the end
        do {
            let separated = separateComponents("Hello my dear dear.", by: "dear..")
            XCTAssertEqual(separated, ["Hello my dear dear."])
        }
        
        // Testing empty string
        do {
            let separated = separateComponents("", by: "dear..")
            XCTAssertEqual(separated, [""])
        }
        
        // Testing empty separator
        do {
            let separated = separateComponents("dear..", by: "")
            XCTAssertEqual(separated, ["dear.."])
        }
        
        // Testing empty string and separator
        do {
            let separated = separateComponents("", by: "")
            XCTAssertEqual(separated, [""])
        }
    }
    
    func componentsOneSplitTester(mode: Mode) throws {
        
        func splitAndPutIntoAnArray(_ string: String, by separator: String) -> [String]? {
            switch getStringProtocol(from: string, mode: mode) {
            case let .string(string):
                if let separated = string.componentsOneSplit(separatedBy: separator) {
                    return [separated.lhs, separated.rhs]
                } else {
                    return nil
                }
            case let .substring(substring):
                if let separated = substring.componentsOneSplit(separatedBy: separator) {
                    return [String(separated.lhs), String(separated.rhs)]
                } else {
                    return nil
                }
            }
        }
        
        // Testing normal usage
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear.", by: "my")
            let unwrapped = try XCTUnwrap(separated)
            XCTAssertEqual(unwrapped, ["Hello ", " dear."])
        }
        
        // Testing separator at the end
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear.", by: "dear.")
            let unwrapped = try XCTUnwrap(separated)
            XCTAssertEqual(unwrapped, ["Hello my ", ""])
        }
        
        // Testing separator at the beginning
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear.", by: "Hell")
            let unwrapped = try XCTUnwrap(separated)
            XCTAssertEqual(unwrapped, ["", "o my dear."])
        }
        
        // Testing only one letter
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear.", by: "m")
            let unwrapped = try XCTUnwrap(separated)
            XCTAssertEqual(unwrapped, ["Hello ", "y dear."])
        }
        
        // Testing only one letter at the end
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear.", by: ".")
            let unwrapped = try XCTUnwrap(separated)
            XCTAssertEqual(unwrapped, ["Hello my dear", ""])
        }
        
        // Testing multiple matching cases
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear dear.", by: "dear")
            let unwrapped = try XCTUnwrap(separated)
            XCTAssertEqual(unwrapped, ["Hello my ", " dear."])
        }
        
        // Testing very similar matching cases
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear dear.", by: "dear.")
            let unwrapped = try XCTUnwrap(separated)
            XCTAssertEqual(unwrapped, ["Hello my dear ", ""])
        }
        
        // Testing no matching cases
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear dear.", by: "dearr")
            XCTAssertEqual(separated, nil)
        }
        
        // Testing no matching cases at the end
        do {
            let separated = splitAndPutIntoAnArray("Hello my dear dear.", by: "dear..")
            XCTAssertEqual(separated, nil)
        }
        
        // Testing a string split by itself
        do {
            let separated = splitAndPutIntoAnArray("dear", by: "dear")
            XCTAssertEqual(separated, ["", ""])
        }
        
        // Testing empty string
        do {
            let separated = splitAndPutIntoAnArray("", by: "dear..")
            XCTAssertEqual(separated, nil)
        }
        
        // Testing half-overlapping cases
        do {
            let separated = splitAndPutIntoAnArray("uretmi.tmi.twitch.tv PRIVMSG", by: "tmi.twitch.tv")
            XCTAssertEqual(separated, ["uretmi.", " PRIVMSG"])
        }
        
        // Testing empty separator
        do {
            let separated = splitAndPutIntoAnArray("Hello", by: "")
            XCTAssertEqual(separated, nil)
        }
        
        // Testing empty string and separator
        do {
            let separated = splitAndPutIntoAnArray("", by: "")
            XCTAssertEqual(separated, nil)
        }
    }
    
    enum StringOrSub {
        case string(String)
        case substring(Substring)
    }
    
    enum Mode {
        case string
        case substring
    }
    
    func getStringProtocol(from string: String, mode: Mode) -> StringOrSub {
        switch mode {
        case .string:
            return .string(string)
        case .substring:
            let newString = "1" + string + "b"
            let range = 1..<(newString.count - 1)
            let startIndex = newString.startIndex
            let lowerBound = newString.index(startIndex, offsetBy: range.lowerBound)
            let upperBound = newString.index(startIndex, offsetBy: range.upperBound)
            return .substring(newString[lowerBound..<upperBound])
        }
    }
}
