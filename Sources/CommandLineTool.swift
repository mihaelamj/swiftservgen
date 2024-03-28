//
//  CommandLineTool.swift
//
//
//  Created by Mihaela MJ on 24.03.2024..
//

import Foundation

struct CommandLineTool {
    
    /// Runs the command line tool, processing the arguments provided.
    static func run(withArguments args: [String] = Array(CommandLine.arguments.dropFirst())) {
        // If no arguments or help is requested, print usage instructions.
        if args.isEmpty || args.contains("--help") {
            printUsage()
            return
        }
        
        // Process each argument
        for arg in args {
            let (command, count) = Parser.parseCLIArgument(arg)
            
            switch command {
            case .int:
                processIntCommand(count: count)
            case .string:
                processStringCommand(count: count)
            default:
                print("Unsupported command: \(arg)")
                printUsage()
            }
        }
    }
    
    /// Runs the command line tool, processing the arguments provided.
    static func run() {
        // Skip the first argument (the path to the executable)
        let args = CommandLine.arguments.dropFirst()
        
        // If no arguments or help is requested, print usage instructions.
        if args.isEmpty || args.contains("--help") {
            printUsage()
            return
        }
        
        // Process each argument
        for arg in args {
            let (command, count) = Parser.parseCLIArgument(arg)
            
            switch command {
            case .int:
                processIntCommand(count: count)
            case .string:
                processStringCommand(count: count)
            default:
                print("Unsupported command: \(arg)")
                printUsage()
            }
        }
    }
    
    /// Processes the 'int' command, generating and printing integers.
    /// - Parameter count: The optional count of integers to generate.
    private static func processIntCommand(count: Int?) {
        if let count = count {
            let numbers = Generator.generateInts(count: count)
            print(numbers)
        } else {
            let number = Generator.generateInt()
            print(number)
        }
    }
    
    /// Processes the 'string' command, generating and printing strings.
    /// - Parameter count: The optional count of strings to generate.
    private static func processStringCommand(count: Int?) {
        if let count = count {
            let strings = Generator.generateStrings(count: count)
            print(strings.joined(separator: ", "))
        } else {
            let string = Generator.generateString()
            print(string)
        }
    }
    
    /// Prints usage instructions for the tool.
    private static func printUsage() {
        let usage = """
        Usage:
          --help                  Show this help message.
          --server                Start the web server.
          int                     Generate a random integer.
          int[x]                  Generate an array of x random integers.
          string                  Generate a random string.
          string[x]               Generate an array of x random strings.
        
        Examples:
          CommandLineTool int
          CommandLineTool int[5]
          CommandLineTool string
          CommandLineTool string[3]
          CommandLineTool --server  Starts the web server.
        
        Use --server to start the web server, or provide commands to generate random integers or strings.
        """
        print(usage)
    }
}

/**
 // Entry point for the command-line tool
 CommandLineTool.run()
 ```
 ### Running the CommandLineTool

 ```bsh
 .build/debug/YourSwiftPackage --help
 .build/debug/YourSwiftPackage int[10] string[5]
 ```
 */
