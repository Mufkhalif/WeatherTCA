//
//  FiveDaysInfo.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

public struct FiveDaysInfo: Codable, Hashable, Identifiable {
    public var id = UUID()
    /// 요일
    let day: String?
    /// 아이콘
    let icon: String?
    /// 최고 기온
    let tempMax: String?
    /// 최저 기온
    let tempMin: String?
}

extension FiveDaysInfo: EntityResponseProtocol {
    public static func null() -> Self {
        return .init(day: nil, icon: nil, tempMax: nil, tempMin: nil)
    }

    public static func empty() -> FiveDaysInfo {
        return .init(day: "", icon: "", tempMax: "", tempMin: "")
    }

    public static func mock() -> FiveDaysInfo {
        return .init(day: "월", icon: "01", tempMax: "10", tempMin: "11")
    }
}
