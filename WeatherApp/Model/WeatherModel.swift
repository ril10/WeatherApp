//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Sergey Luk on 25.11.20.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let country: String
    let description: String
    let windSpeed: Double
    let feelsLike: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temperature) + "C°"
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }

    
}
