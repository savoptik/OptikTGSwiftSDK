//
// Created by Артём Семёнов on 20.07.2021.
//

import Foundation

public struct Update : Decodable {
    public let update_id: UInt
    public let message: Message

    private enum Keys: String, CodingKey {
        case update_id, message
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        update_id = try container.decode(UInt.self, forKey: .update_id)
        message = try container.decode(Message.self, forKey: .message)
    }
}
