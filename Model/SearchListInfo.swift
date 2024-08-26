//
//  SearchListInfo.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

struct SearchListInfo: Codable, Hashable {
    /// 이름
    let name: String?
    /// 나라
    let country: String?
}

extension SearchListInfo: EntityResponseProtocol {
    static func null() -> Self {
        return .init(name: nil, country: nil)
    }

    static func empty() -> Self {
        return .init(name: "", country: "")
    }

    static func mock() -> Self {
        return .init(name: "Asan", country: "kr")
    }
}
