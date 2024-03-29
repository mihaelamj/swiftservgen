//
//  StuffGeneratorTests.swift
//  
//
//  Created by Mihaela MJ on 29.03.2024..
//

import XCTest
@testable import StuffGenerator

final class StuffGeneratorTests: XCTestCase {

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
    
    func testGenerateInt() {
        // Generate an integer within a custom range
        let customRange = 50...60
        let generatedInt = StuffGenerator.generateInt(in: customRange)
        XCTAssertTrue(customRange.contains(generatedInt), "Generated int should be within the custom range")
    }
    
    func testGenerateInts() {
        // Generate an array of integers
        let count = 5
        let customRange = 1...100
        let generatedInts = StuffGenerator.generateInts(count: count, in: customRange)
        XCTAssertEqual(generatedInts.count, count, "Array should contain the specified number of integers")
        XCTAssertTrue(generatedInts.allSatisfy(customRange.contains), "All generated ints should be within the custom range")
    }
    
    func testGenerateString() {
        // Generate a string of a specific length
        let length = 20
        let characters = "abc"
        let generatedString = StuffGenerator.generateString(length: length, characters: characters)
        XCTAssertEqual(generatedString.count, length, "Generated string should have the specified length")
        XCTAssertTrue(generatedString.allSatisfy { characters.contains($0) }, "Generated string should only contain specified characters")
    }
    
    func testGenerateStrings() {
        // Generate an array of strings
        let count = 5
        let length = 8
        let characters = "0123456789"
        let generatedStrings = StuffGenerator.generateStrings(count: count, length: length, characters: characters)
        XCTAssertEqual(generatedStrings.count, count, "Array should contain the specified number of strings")
        XCTAssertTrue(generatedStrings.allSatisfy { $0.count == length }, "All generated strings should have the specified length")
        XCTAssertTrue(generatedStrings.allSatisfy { $0.allSatisfy { characters.contains($0) } }, "All generated strings should only contain specified characters")
    }

}
