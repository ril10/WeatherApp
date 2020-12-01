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
    //Формируем ссылку с городом и апи запросом и в конце передаем его на функцию ветер дата с конечной ссылкой для запроса
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        weatherData(urlString: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon\(longtitude)"
        weatherData(urlString: urlString)
    }
    
    
    
    func weatherData(urlString: String) {
        //создаем переменную которая принмает ссылку и конвертирует ее в адресс
        guard let url = URL(string: urlString) else {return}
        //создается сессия
        let session = URLSession.shared
        //метод комплетишн хэндлер дата данные,респонсе статус запроса,и error
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
          if let dataWeather = self.parseJSON(data) {
            self.delegate?.updateWeather(self, weather: dataWeather)
            }
            print(data)
            do{
                //получаем данные с помощью джсон сериализейшн
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?  {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let name = decodedData.name
            print("f")
            let weather = WeatherModel(cityName: name, temperature: temp)
            return weather
        } catch {
            print(error)
            return nil
        }
    }
    
}





