//
//  WebServer.swift
//
//
//  Created by Mihaela MJ on 24.03.2024..
//

import Foundation
import NIO
import NIOHTTP1
import ArgumentParser
import StuffGenerator

final class HTTPHandler: ChannelInboundHandler {
    typealias InboundIn = HTTPServerRequestPart
    typealias OutboundOut = HTTPServerResponsePart

    var buffer: ByteBuffer! = nil

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let reqPart = self.unwrapInboundIn(data)

        switch reqPart {
        case .head(let request):
            buffer = context.channel.allocator.buffer(capacity: 0)  // Reset the buffer for a new request
            let (command, count) = ArgumentParser.parseURI(request.uri)
            let response: String
            
            switch command {
            case .int:
                if let count = count {
                    response = "\(StuffGenerator.generateInts(count: count))"
                } else {
                    response = "\(StuffGenerator.generateInt())"
                }
            case .string:
                if let count = count {
                    response = StuffGenerator.generateStrings(count: count).joined(separator: ", ")
                } else {
                    response = StuffGenerator.generateString()
                }
            default:
                response = "Unsupported operation"
            }
            
            buffer.writeString(response)
            
        case .end:
            // After receiving the end of the request, write the HTTP response header and body.
            let keepAlive = false
            let headers: HTTPHeaders = [
                "content-type": "text/plain; charset=utf-8",
                "content-length": String(buffer.readableBytes),
                "connection": keepAlive ? "keep-alive" : "close"
            ]
            
            let head = HTTPResponseHead(version: .init(major: 1, minor: 1), status: .ok, headers: headers)
            context.write(self.wrapOutboundOut(.head(head)), promise: nil)
            
            context.write(self.wrapOutboundOut(.body(.byteBuffer(buffer))), promise: nil)
            
            let endPromise = context.eventLoop.makePromise(of: Void.self)
            endPromise.futureResult.whenComplete { _ in
                context.close(promise: nil)
            }
            context.writeAndFlush(self.wrapOutboundOut(.end(nil)), promise: endPromise)
            buffer = nil  // Clear the buffer for the next request

        default:
            break
        }
    }

    public func channelReadComplete(context: ChannelHandlerContext) {
        context.flush()
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("Error: \(error)")
        context.close(promise: nil)
    }
}


struct WebServer {
    static func start() throws -> Channel {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
        let bootstrap = ServerBootstrap(group: group)
            // ServerBootstrap configuration...
            .childChannelInitializer { channel in
                channel.pipeline.configureHTTPServerPipeline().flatMap {
                    channel.pipeline.addHandler(HTTPHandler())
                }
            }
        
        let channel = try bootstrap.bind(host: "localhost", port: 8080).wait()
        print("Server started on \(channel.localAddress!)")
        return channel
    }
}


