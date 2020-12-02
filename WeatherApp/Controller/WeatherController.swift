//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sergey Luk on 20.11.20.
//

import UIKit
import CoreLocation

class WeatherController: UIViewController{

    

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var weatherIndicator: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperatureDegree: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

    }

}

extension WeatherController: WeatherManagerDelegate {
    
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureDegree.text = weather.temperatureString
            self.weatherIndicator.image = UIImage(systemName: weather.conditionName)
            self.cityName.text = weather.cityName
        }
    }
    
}

extension WeatherController: UITextFieldDelegate {
    
    @IBAction func seachButton(_ sender: UIButton) {
        searchField.endEditing(true)
        print(searchField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something here"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if let city = searchField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchField.text = ""
    }

}

extension WeatherController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longtitude: lon)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    @IBAction func geoLocation(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
}
