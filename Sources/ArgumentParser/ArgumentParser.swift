//
//  ArgumentParser.swift
//  
//
//  Created by Mihaela MJ on 24.03.2024..
//

/**
 `/int` should generate one int as a response
 `/int[5]` should generate an array of 5 ints  as a response
 `/string` should generate one string  as a response
 `/string[5]` should generate an array of 5 strings  as a response
 I also wanna be able to use command line as a parallel input to the library to generate the same results
 */

import Foundation

public struct ArgumentParser {
    
    public enum CommandType {
        case int
        case string
        
        /// Initializes a CommandType from a string value, if possible.
        init?(from string: String) {
            switch string.lowercased() {
            case "int":
                self = .int
            case "string":
                self = .string
            default:
                return nil
            }
        }
    }
    /// Parses a string input to determine the requested action and any numerical parameters.
     /// The input can be a URI from an HTTP request or a command-line argument.
     /// - Parameter input: The string input to parse.
     /// - Returns: A tuple containing the command (`int` or `string`) and an optional count for array generation.
    private static func parseInput(_ input: String) -> (command: CommandType?, count: Int?) {
        // Normalize input by trimming leading "/" if present
        let normalizedInput = input.hasPrefix("/") ? String(input.dropFirst()) : input

        // Attempt to isolate a command and optional count
        if let openBracketIndex = normalizedInput.lastIndex(of: "["),
           let closeBracketIndex = normalizedInput.lastIndex(of: "]"),
           openBracketIndex < closeBracketIndex {
            
            let commandString = String(normalizedInput[..<openBracketIndex])
            let countString = String(normalizedInput[normalizedInput.index(after: openBracketIndex)..<closeBracketIndex])
            
            if let count = Int(countString), let command = CommandType(from: commandString) {
                return (command, count)
            }
        } else if let command = CommandType(from: normalizedInput) {
            // If there's no count specified, it might still be a valid command
            return (command, nil)
        }

        // Return nil if no known command is detected or parsing fails
        return (nil, nil)
    }
}

public extension ArgumentParser {
    
    /// Parses the URI from an HTTP request using the shared parsing logic.
    /// - Parameter uri: The URI string from the HTTP request.
    /// - Returns: A tuple of the command and an optional count.
    static func parseURI(_ uri: String) -> (command: CommandType?, count: Int?) {
        return parseInput(uri)
    }
    
    /// Parses a command-line argument using the shared parsing logic.
    /// - Parameter arg: The command-line argument.
    /// - Returns: A tuple of the command and an optional count.
    static func parseCLIArgument(_ arg: String) -> (command: CommandType?, count: Int?) {
        return parseInput(arg)
    }
    
}
