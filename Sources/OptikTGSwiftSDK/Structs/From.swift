//
// Created by Артём Семёнов on 20.07.2021.
//

import Foundation

public struct From : ExUserProtocol {
    public let id: UInt
    public let is_bot: Bool
    public let                first_name: String
    public let last_name: String
    public let username: String
    public let language_code: String

    private enum Keys : String, CodingKey {
        case id, is_bot, first_name, last_name, username, language_code
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(UInt.self, forKey: .id)
        is_bot = try container.decode(Bool.self, forKey: .is_bot)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        username = try container.decode(String.self, forKey: .username)
        language_code = try container.decode(String.self, forKey: .language_code)
    }
}
