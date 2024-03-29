//
//  ArgumentParserTests.swift
//  
//
//  Created by Mihaela MJ on 29.03.2024..
//

import XCTest
@testable import ArgumentParser

final class ArgumentParserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testArgumentParser() {
        // Test cases for both URIs and CLI arguments
        let testCases = [
            ("/int", (command: ArgumentParser.CommandType.int, count: nil)),
            ("int", (command: ArgumentParser.CommandType.int, count: nil)), // CLI equivalent
            ("/int[5]", (command: ArgumentParser.CommandType.int, count: 5)),
            ("int[5]", (command: ArgumentParser.CommandType.int, count: 5)), // CLI equivalent
            ("/string", (command: ArgumentParser.CommandType.string, count: nil)),
            ("string", (command: ArgumentParser.CommandType.string, count: nil)), // CLI equivalent
            ("/string[5]", (command: ArgumentParser.CommandType.string, count: 5)),
            ("string[5]", (command: ArgumentParser.CommandType.string, count: 5)) // CLI equivalent
        ]

        testCases.forEach { testCase in
            var result = ArgumentParser.parseURI(testCase.0)
            XCTAssertEqual(result.command, testCase.1.command, "Command mismatch for URI input: \(testCase.0)")
            XCTAssertEqual(result.count, testCase.1.count, "Count mismatch for URI input: \(testCase.0)")

            // Test the equivalent CLI argument parsing
            result = ArgumentParser.parseCLIArgument(testCase.0.starts(with: "/") ? String(testCase.0.dropFirst()) : testCase.0)
            XCTAssertEqual(result.command, testCase.1.command, "Command mismatch for CLI input: \(testCase.0)")
            XCTAssertEqual(result.count, testCase.1.count, "Count mismatch for CLI input: \(testCase.0)")
        }
    }

}
