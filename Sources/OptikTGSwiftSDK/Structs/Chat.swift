//
// Created by Артём Семёнов on 20.07.2021.
//

import Foundation

public struct Chat : UserProtocol {
    public let id: UInt
    public let                first_name: String
    public let last_name: String
    public let username: String
    let type: String

    private enum Keys : String, CodingKey {
        case id, first_name, last_name, username, type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(UInt.self, forKey: .id)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        username = try container.decode(String.self, forKey: .username)
        type = try container.decode(String.self, forKey: .type)
    }
}
