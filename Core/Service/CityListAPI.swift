//
//  CityListAPI.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

public struct CityListAPI: Codable {
//    static let path = "citylist.json"
    static let path = Bundle.main.url(forResource: "citylist", withExtension: "json")
//    static let path = Bundle.main.path(forResource: "citylist", ofType: "json")

    public struct Response: Codable, Hashable {
        let id: Int?
        let name, country: String?
        let coord: Coord?
    }
}
