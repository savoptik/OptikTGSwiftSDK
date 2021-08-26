//
// Created by Артём Семёнов on 04.08.2021.
//

import Foundation

public protocol BotDelegate {
    var masterNAme: String { get }
    var handlers: [([Update]) -> ()] { get set }
    var token: Token { get }
    var signalHandler: (@convention(c) (Int32) -> Void)? { get }

    func botDedLoad(commandLineArguments: [String])
    func botDedTerminate(commandLineArguments: [String])
}
