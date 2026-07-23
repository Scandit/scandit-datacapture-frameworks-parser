/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import Foundation

class ParseRequest {
    let parserId: String
    let data: String

    init(parserId: String, data: String) {
        self.parserId = parserId
        self.data = data
    }

    private init(json: [String: Any]) {
        self.parserId = ParseRequest.getParserId(json)
        self.data = ParseRequest.getData(json)
    }

    static func decode(parsingData: String) -> ParseRequest {
        guard let data = parsingData.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            return ParseRequest(parserId: "unknown", data: "")
        }
        return ParseRequest(json: json)
    }

    private static func getParserId(_ json: [String: Any]) -> String {
        if let parserId = json["parserId"] as? String {
            return parserId
        }

        if let id = json["id"] as? String {
            return id
        }

        return "unknown"
    }

    private static func getData(_ json: [String: Any]) -> String {
        json["data"] as? String ?? ""
    }
}
