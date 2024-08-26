//
//  ForecastAPI.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

public struct ForecastAPI: Codable {
    static let path = "/forecast"

    public struct Request: Codable {
        let lat: String
        let lon: String
        let appid: String?
        let units: String?
        let mode: String?
        let cnt: String?
        let lang: String?
    }

    public struct Response: Codable, Hashable {
        let cod: String?
        let message, cnt: Int?
        let list: [ForecastList]?
        let city: City?
    }
}

// MARK: - City

struct City: Codable, Hashable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - List

struct ForecastList: Codable, Hashable {
    let dt: Int?
    let main: MainClass?
    let weather: [ForecastWeather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let rain: ForecastRain?
    let sys: ForecastSys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }

    var hour: String? {
        let time = dtTxt?.split(separator: " ").last.map { String($0) }

        return time?.split(separator: ":").first.map { String($0) } ?? ""
    }
}

// MARK: - MainClass

struct MainClass: Codable, Hashable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain

struct ForecastRain: Codable, Hashable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys

struct ForecastSys: Codable, Hashable {
    let pod: String?
}

// MARK: - Weather

struct ForecastWeather: Codable, Hashable {
    let id: Int
    let main, description, icon: String?

    var imageString: String {
        return String(icon?.dropLast() ?? "")
    }
}
