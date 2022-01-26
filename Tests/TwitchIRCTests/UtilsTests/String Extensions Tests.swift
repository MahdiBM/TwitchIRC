@testable import TwitchIRC
import XCTest

final class StringExtensionTests: XCTestCase {
    
    func testComponentsOneSplit() throws {
        
        func splitAndPutIntoAnArray(_ string: String, by separator: String) -> [String]? {
            if let separated = string.componentsOneSplit(separatedBy: separator) {
                return [separated.lhs, separated.rhs]
            } else {
                return nil
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
    
    func testComponentsSeparatedBy() throws {
        
        // Testing normal usage
        do {
            let separated = "Hello my dear.".components(separatedBy: "my")
            XCTAssertEqual(separated, ["Hello ", " dear."])
        }
        
        // Testing separator at the end
        do {
            let separated = "Hello my dear.".components(separatedBy: "dear.")
            XCTAssertEqual(separated, ["Hello my ", ""])
        }
        
        // Testing separator at the beginning
        do {
            let separated = "Hello my dear.".components(separatedBy: "Hell")
            XCTAssertEqual(separated, ["", "o my dear."])
        }
        
        // Testing only one letter
        do {
            let separated = "Hello my dear.".components(separatedBy: "m")
            XCTAssertEqual(separated, ["Hello ", "y dear."])
        }
        
        // Testing only one letter at the end
        do {
            let separated = "Hello my dear.".components(separatedBy: ".")
            XCTAssertEqual(separated, ["Hello my dear", ""])
        }
        
        // Testing multiple matching cases
        do {
            let separated = "Hello my dear dear.".components(separatedBy: "dear")
            XCTAssertEqual(separated, ["Hello my ", " ", "."])
        }
        
        // Testing multiple matching cases 2
        do {
            let separated = "dear Hello my deardear".components(separatedBy: "dear")
            XCTAssertEqual(separated, ["", " Hello my ", "", ""])
        }
        
        // Testing very similar matching cases
        do {
            let separated = "Hello my dear dear.".components(separatedBy: "dear.")
            XCTAssertEqual(separated, ["Hello my dear ", ""])
        }
        
        // Testing a string split by itself
        do {
            let separated = "dear".components(separatedBy: "dear")
            XCTAssertEqual(separated, ["", ""])
        }
        
        // Testing 2x(a string) split by itself
        do {
            let separated = "deardear".components(separatedBy: "dear")
            XCTAssertEqual(separated, ["", "", ""])
        }
        
        // Testing no matching cases
        do {
            let separated = "Hello my dear dear.".components(separatedBy: "dearr")
            XCTAssertEqual(separated, ["Hello my dear dear."])
        }
        
        // Testing no matching cases at the end
        do {
            let separated = "Hello my dear dear.".components(separatedBy: "dear..")
            XCTAssertEqual(separated, ["Hello my dear dear."])
        }
        
        // Testing empty string
        do {
            let separated = "".components(separatedBy: "dear..")
            XCTAssertEqual(separated, [""])
        }
        
        // Testing empty separator
        do {
            let separated = "dear..".components(separatedBy: "")
            XCTAssertEqual(separated, ["dear.."])
        }
        
        // Testing empty string and separator
        do {
            let separated = "".components(separatedBy: "")
            XCTAssertEqual(separated, [""])
        }
        
    }
    
}
