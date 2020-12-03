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
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
