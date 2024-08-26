//
//  ThreeHoursInfo.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

public struct ThreeHoursInfo: Codable, Hashable, Identifiable {
    public var id = UUID()
    /// 시간
    let hours: String?
    /// 아이콘
    let icon: String?
    /// 기온
    let temp: String?
}

extension ThreeHoursInfo: EntityResponseProtocol {
    public static func null() -> Self {
        return .init(hours: nil, icon: nil, temp: nil)
    }

    public static func empty() -> Self {
        return .init(hours: "", icon: .none, temp: "")
    }

    public static func mock() -> Self {
        return .init(hours: "1", icon: "01", temp: "10")
    }
}
