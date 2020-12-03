//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Sergey Luk on 23.11.20.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}


struct WeatherManager {

    var delegate: WeatherManagerDelegate?
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=1f54f0d45461d225b61efc1ac022c081&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        weatherData(urlString: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longtitude)"
        weatherData(urlString: urlString)
    }
    
    
    
    func weatherData(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error as Any)
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.updateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?  {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let country = decodedData.sys.country
            let description = decodedData.weather[0].description
            let windSpeed = decodedData.wind.speed
            let feelsLike = decodedData.main.feels_like
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, country: country, description: description, windSpeed: windSpeed, feelsLike: feelsLike)
            
            return weather
        } catch {
            print(error)
            return nil
        }
    }
    
}





