//
//  Parsing.swift
//
//
//  Created by Mihaela MJ on 23.03.2024..
//

import Foundation

struct Parser {
    /// Parses a string input to determine the requested action and any numerical parameters.
    /// The input can be a URI from an HTTP request or a command-line argument.
    /// - Parameter input: The string input to parse.
    /// - Returns: A tuple containing the command (`int` or `string`) and an optional count for array generation.
    private static func parseInput(_ input: String) -> (command: String, count: Int?) {
        // Regex pattern to match inputs like "int[3]", "string[10]", "/int", or "/string"
        let pattern = "^(?:/)?(int|string)(\\[(\\d+)\\])?$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return ("", nil) }
        
        let nsrange = NSRange(input.startIndex..<input.endIndex, in: input)
        if let match = regex.firstMatch(in: input, options: [], range: nsrange) {
            let commandRange = Range(match.range(at: 1), in: input)!
            let command = String(input[commandRange])
            
            var count: Int? = nil
            if let countRange = Range(match.range(at: 3), in: input), !countRange.isEmpty {
                count = Int(input[countRange])
            }
            
            return (command, count)
        }
        
        return ("", nil)
    }

    /// Parses the URI from an HTTP request using the shared parsing logic.
    /// - Parameter uri: The URI string from the HTTP request.
    /// - Returns: A tuple of the command and an optional count.
    static func parseURI(_ uri: String) -> (command: String, count: Int?) {
        return parseInput(uri)
    }
    
    /// Parses a command-line argument using the shared parsing logic.
    /// - Parameter arg: The command-line argument.
    /// - Returns: A tuple of the command and an optional count.
    static func parseCLIArgument(_ arg: String) -> (command: String, count: Int?) {
        return parseInput(arg)
    }
}
