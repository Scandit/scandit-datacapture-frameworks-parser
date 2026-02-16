/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

// THIS FILE IS GENERATED. DO NOT EDIT MANUALLY.
// Generator: scripts/bridge_generator/generate.py
// Schema: scripts/bridge_generator/schemas/parser.json

import Foundation
import ScanditFrameworksCore

/// Generated ParserModule command implementations.
/// Each command extracts parameters in its initializer and executes via ParserModule.

/// Parses a string and returns structured data
public class ParseStringCommand: ParserModuleCommand {
    private let module: ParserModule
    private let parserId: String
    private let data: String
    public init(module: ParserModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.parserId = method.argument(key: "parserId") ?? ""
        self.data = method.argument(key: "data") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !parserId.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'parserId' is missing", details: nil)
            return
        }
        guard !data.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'data' is missing", details: nil)
            return
        }
        module.parseString(
            parserId: parserId,
            data: data,
            result: result
        )
    }
}
/// Parses raw data and returns structured data
public class ParseRawDataCommand: ParserModuleCommand {
    private let module: ParserModule
    private let parserId: String
    private let data: String
    public init(module: ParserModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.parserId = method.argument(key: "parserId") ?? ""
        self.data = method.argument(key: "data") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !parserId.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'parserId' is missing", details: nil)
            return
        }
        guard !data.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'data' is missing", details: nil)
            return
        }
        module.parseRawData(
            parserId: parserId,
            data: data,
            result: result
        )
    }
}
/// Creates or updates a native parser instance
public class CreateUpdateNativeInstanceCommand: ParserModuleCommand {
    private let module: ParserModule
    private let parserJson: String
    public init(module: ParserModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.parserJson = method.argument(key: "parserJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !parserJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'parserJson' is missing",
                details: nil
            )
            return
        }
        module.createUpdateNativeInstance(
            parserJson: parserJson,
            result: result
        )
    }
}
/// Disposes the parser instance and releases resources
public class DisposeParserCommand: ParserModuleCommand {
    private let module: ParserModule
    private let parserId: String
    public init(module: ParserModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.parserId = method.argument(key: "parserId") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !parserId.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'parserId' is missing", details: nil)
            return
        }
        module.disposeParser(
            parserId: parserId,
            result: result
        )
    }
}
