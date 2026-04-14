/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore
import ScanditParser

public enum ParserError: Error {
    case componentNotFound
    case invalidBase64Data
    case dataCaptureNotInitialized
}

open class ParserModule: NSObject, FrameworkModule, DeserializationLifeCycleObserver {
    private let parserDeserializer: ParserDeserializer
    private let captureContext = DefaultFrameworksCaptureContext.shared

    public init(deserializer: ParserDeserializer = ParserDeserializer()) {
        self.parserDeserializer = deserializer
    }

    private var parsers: [String: Parser] = [:]

    public func didStart() {
        parserDeserializer.delegate = self
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        parserDeserializer.delegate = nil
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
    }

    public func getDefaults() -> [String: Any?] {
        [:]
    }

    public func parse(parsingData: String, result: FrameworksResult) {
        let request = ParseRequest.decode(parsingData: parsingData)
        parseString(parserId: request.parserId, data: request.data, result: result)
    }

    public func parseString(parserId: String, data: String, result: FrameworksResult) {
        guard let parser = parsers[parserId] else {
            result.reject(error: ParserError.componentNotFound)
            return
        }
        do {
            let parserResult = try parser.parseString(data)
            result.success(result: parserResult.jsonString)
        } catch {
            result.reject(error: error)
        }
    }

    public func parseRawData(parsingData: String, result: FrameworksResult) {
        let request = ParseRequest.decode(parsingData: parsingData)
        parseRawData(parserId: request.parserId, data: request.data, result: result)
    }

    public func parseRawData(parserId: String, data: String, result: FrameworksResult) {
        guard let parser = parsers[parserId] else {
            result.reject(error: ParserError.componentNotFound)
            return
        }
        guard let data = Data(base64Encoded: data) else {
            result.reject(error: ParserError.invalidBase64Data)
            return
        }
        do {
            let parserResult = try parser.parseRawData(data)
            result.success(result: parserResult.jsonString)
        } catch {
            result.reject(error: error)
        }
    }

    public func didDisposeDataCaptureContext() {
        self.parsers.removeAll()
    }

    public func createUpdateNativeInstance(parserJson: String, result: FrameworksResult) {
        guard let dcContext = captureContext.context else {
            result.reject(error: ParserError.dataCaptureNotInitialized)
            return
        }

        do {
            try parserDeserializer.parser(fromJSONString: parserJson, context: dcContext)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func disposeParser(parserId: String, result: FrameworksResult) {
        parsers.removeValue(forKey: parserId)
        result.success(result: nil)
    }

    public func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        ParserModuleCommandFactory.create(module: self, method)
    }
}

extension ParserModule: ParserDeserializerDelegate {
    public func parserDeserializer(
        _ parserDeserializer: ParserDeserializer,
        didStartDeserializingParser parser: Parser,
        from jsonValue: JSONValue
    ) {}

    public func parserDeserializer(
        _ parserDeserializer: ParserDeserializer,
        didFinishDeserializingParser parser: Parser,
        from jsonValue: JSONValue
    ) {
        parsers[parser.componentId] = parser
    }
}
