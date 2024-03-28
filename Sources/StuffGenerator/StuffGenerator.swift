//
//  StuffGenerator.swift
//
//
//  Created by Mihaela MJ on 23.03.2024..
//

import Foundation

struct StuffGenerator {
    /// Generates a random integer within a specified range.
    /// - Parameters:
    ///   - range: The range within which to generate the integer. Default is 1...100.
    /// - Returns: A randomly generated integer within the specified range.
    static func generateInt(in range: ClosedRange<Int> = 1...100) -> Int {
        return Int.random(in: range)
    }
    
    /// Generates an array of random integers.
    /// - Parameters:
    ///   - count: The number of integers to generate.
    ///   - range: The range within which to generate each integer. Default is 1...100.
    /// - Returns: An array of randomly generated integers.
    static func generateInts(count: Int, in range: ClosedRange<Int> = 1...100) -> [Int] {
        return (0..<count).map { _ in generateInt(in: range) }
    }
    
    /// Generates a random string of a specified length using given characters.
    /// - Parameters:
    ///   - length: The length of the string to generate. Default is 10.
    ///   - characters: A string representing the set of characters to use. Default is alphanumeric characters.
    /// - Returns: A randomly generated string.
    static func generateString(length: Int = 10, characters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
    
    /// Generates an array of random strings.
    /// - Parameters:
    ///   - count: The number of strings to generate.
    ///   - length: The length of each string to generate. Default is 10.
    ///   - characters: A string representing the set of characters to use for each string. Default is alphanumeric characters.
    /// - Returns: An array of randomly generated strings.
    static func generateStrings(count: Int, length: Int = 10, characters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> [String] {
        return (0..<count).map { _ in generateString(length: length, characters: characters) }
    }
}
