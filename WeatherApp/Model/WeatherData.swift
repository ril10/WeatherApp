//
//  WeatherJson.swift
//  WeatherApp
//
//  Created by Sergey Luk on 25.11.20.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Sys: Codable {
    let country: String
}

struct Wind: Codable {
    let speed: Double
}
