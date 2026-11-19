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

/// Factory for creating ParserModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class ParserModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The ParserModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(module: ParserModule, _ method: FrameworksMethodCall) -> ParserModuleCommand? {
        switch method.method {
        case "parseString":
            return ParseStringCommand(module: module, method)
        case "parseRawData":
            return ParseRawDataCommand(module: module, method)
        case "createUpdateNativeInstance":
            return CreateUpdateNativeInstanceCommand(module: module, method)
        case "disposeParser":
            return DisposeParserCommand(module: module, method)
        default:
            return nil
        }
    }
}
