//
//  WeatherAPI.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

// MARK: - WeatherAPI

public struct WeatherAPI: Codable {
    static let path = "/weather"

    public struct Request: Codable {
        let lat: String
        let lon: String
        let appid: String?
        let units: String?
        let mode: String?
        let lang: String?
    }

    public struct Response: Codable, Hashable {
        let coord: Coord?
        let weather: [Weather]?
        let base: String?
        let main: Main?
        let visibility: Int?
        let wind: Wind?
        let rain: Rain?
        let clouds: Clouds?
        let dt: Int?
        let sys: Sys?
        let timezone, id: Int?
        let name: String?
        let cod: Int?
    }
}

// MARK: - Clouds

struct Clouds: Codable, Hashable {
    let all: Int?

    static func empty() -> Self {
        return Clouds(all: nil)
    }
}

// MARK: - Coord

struct Coord: Codable, Hashable {
    let lon, lat: Double?

    static func empty() -> Self {
        return Coord(lon: nil, lat: nil)
    }
}

// MARK: - Main

struct Main: Codable, Hashable {
    let temp, feels_like, temp_min, temp_max: Double?
    let pressure, humidity, sea_level, grnd_level: Int?

    static func empty() -> Self {
        return Main(temp: nil, feels_like: nil, temp_min: nil, temp_max: nil, pressure: nil, humidity: nil, sea_level: nil, grnd_level: nil)
    }
}

// MARK: - Rain

struct Rain: Codable, Hashable {
    let the1H: Double?

    static func empty() -> Self {
        return Rain(the1H: nil)
    }
}

// MARK: - Sys

struct Sys: Codable, Hashable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?

    static func empty() -> Self {
        return Sys(type: nil, id: nil, country: nil, sunrise: nil, sunset: nil)
    }
}

// MARK: - Weather

struct Weather: Codable, Hashable {
    let id: Int?
    let main, description, icon: String?

    static func empty() -> Self {
        return Weather(id: nil, main: nil, description: nil, icon: nil)
    }

    var imageString: String {
        return String(icon?.dropLast() ?? "")
    }
}

// MARK: - Wind

struct Wind: Codable, Hashable {
    let speed: Double?
    let deg: Int?
    let gust: Double?

    static func empty() -> Self {
        return Wind(speed: nil, deg: nil, gust: nil)
    }
}
