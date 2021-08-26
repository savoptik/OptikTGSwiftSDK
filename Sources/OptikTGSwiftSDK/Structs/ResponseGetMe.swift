//
// Created by Артём Семёнов on 18.07.2021.
//

import Foundation

public struct ResponseGetMe : Decodable {
    public let ok: Bool
    public let result: ResultGetMe

    private enum Keys: String, CodingKey {
        case ok, result
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        ok = try container.decode(Bool.self, forKey: .ok)
        result = try container.decode(ResultGetMe.self, forKey: .result)
    }
}