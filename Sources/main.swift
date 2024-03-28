//
//  main.swift
//
//
//  Created by Mihaela MJ on 28.03.2024..
//

import Foundation
import NIO

var serverChannel: Channel?

func startWebServer() throws {
    // Assuming `startWebServer` is defined within WebServer.swift and returns a `Channel`
    serverChannel = try WebServer.start()
    print("Server started on \(serverChannel!.localAddress!)")
}

func stopWebServer() {
    // Gracefully shutdown the server
    serverChannel?.close(mode: .all, promise: nil)
    print("Server stopped.")
    serverChannel = nil
}

func startInteractiveMode() {
    print("Interactive mode:")
    print("[1] Start web server (--server)")
    print("[2] Run CLI tool (Enter CLI commands directly)")
    print("[3] Exit (exit)")
    print("Enter 'help' for these options at any time.")
    
    while true {
        print("> ", terminator: "")
        guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() else { continue }
        
        switch input {
        case "--server":
            do {
                try startWebServer()
                print("Web server is running. Type 'stop' to stop the server and return to the interactive mode.")
                while let serverCommand = readLine(), serverCommand.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() != "stop" {
                    print("Server is running. Type 'stop' to stop the server.")
                }
                stopWebServer()
            } catch {
                print("Failed to start the web server: \(error.localizedDescription)")
            }
        case "help":
            print("Interactive mode:")
            print("[1] Start web server (--server)")
            print("[2] Run CLI tool (Enter CLI commands directly)")
            print("[3] Exit (exit)")
        case "exit":
            print("Exiting...")
            return
        default:
            CommandLineTool.run(withArguments: [input])
        }
    }
}

// Run the interactive mode as the entry point
startInteractiveMode()


