//
//  CurrentWeather.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

public struct CurrentWeather: Codable, Hashable {
    /// 지역
    let name: String?
    /// 날씨상태
    let description: String?
    /// 현재기온
    let temp: String?
    /// 최저기온
    let tempMin: String?
    /// 최고기온
    let tempMax: String?
    /// 아이콘 이미지
    let imageString: String?
}

extension CurrentWeather: EntityResponseProtocol {
    public static func null() -> Self {
        return .init(name: nil, description: nil, temp: nil, tempMin: nil, tempMax: nil, imageString: nil)
    }

    public static func empty() -> CurrentWeather {
        return .init(name: "", description: "", temp: "", tempMin: "", tempMax: "", imageString: "")
    }

    public static func mock() -> CurrentWeather {
        return .init(name: "Seoul", description: "맑음", temp: "26.74", tempMin: "26.66", tempMax: "26.76", imageString: "01")
    }
}
