//
//  OpenWeather.swift
//  WeatherLogger
//
//  Created by Ali Emre Değirmenci on 23.10.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//
import Foundation

// MARK: - OpenWeather
struct OpenWeather: Codable {
    let coord: Coord
    let weather: [Weather]
//    let base: String
    let main: Main
//    let visibility: Int
//    let wind: Wind
//    let clouds: Clouds
//    let dt: Int?
//    let sys: Sys
//    let timezone: Int
//    let id: Int?
    let name: String
//    let cod: Int?
}

// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int
//}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
//    let pressure, humidity: Int


//    enum CodingKeys: String, CodingKey {
//        case temp, pressure, humidity
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//    }
}

// MARK: - Sys
//struct Sys: Codable {
//    let type, id: Int
//    let country: String
//    let sunrise, sunset: Int
//}

// MARK: - Weather
struct Weather: Codable {
//    let id: Int?
//    let main: String?
    let description: String
//    let icon: String?

//    enum CodingKeys: String, CodingKey {
//        case id, main
//        case weatherDescription = "description"
//        case icon
//    }
}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed: Double
//    let deg: Int
//}

