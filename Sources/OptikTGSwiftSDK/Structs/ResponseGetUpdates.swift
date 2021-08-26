//
// Created by Артём Семёнов on 20.07.2021.
//

import Foundation

public struct ResponseGetUpdates: Decodable {
    public let ok: Bool
    public let result: [Update]

    private enum Keys: String, CodingKey {
        case ok, result
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        ok = try container.decode(Bool.self, forKey: .ok)
        result = try container.decode([Update].self, forKey: .result)
    }
}
