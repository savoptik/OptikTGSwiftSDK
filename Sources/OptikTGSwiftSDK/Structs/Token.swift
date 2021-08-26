//
//  token.swift
//  
//
//  Created by Артём Семёнов on 29.04.2021.
//

import Foundation

public struct Token: Codable {
    public let token: String
    public let name: String
    public let UserName: String

    private enum Keys : String, CodingKey {
        case name, token, UserName
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        name = try container.decode(String.self, forKey: .name)
        UserName = try container.decode(String.self, forKey: .UserName)
        token = try container.decode(String.self, forKey: .token)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.UserName, forKey: .UserName)
        try container.encode(self.token, forKey: .token)
    }
}
