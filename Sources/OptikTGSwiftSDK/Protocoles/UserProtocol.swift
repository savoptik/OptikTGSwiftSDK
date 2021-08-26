//
//  User.swift
//  
//
//  Created by Артём Семёнов on 29.04.2021.
//

import Foundation

public protocol UserProtocol: Decodable {
    var id: UInt { get }
    var first_name: String { get }
    var username: String { get }
}
