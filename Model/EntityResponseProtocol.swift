//
//  EntityResponseProtocol.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

public protocol EntityResponseProtocol: Codable, Hashable {
    static func null() -> Self
    static func empty() -> Self
    static func mock() -> Self
}
