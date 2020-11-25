//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sergey Luk on 20.11.20.
//

import UIKit
import CoreLocation

class WeatherController: UIViewController, WeatherManagerDelegate {
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
    }
    

    var weatherManager = WeatherManager()

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var weatherIndicator: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperatureDegree: UILabel!
    
    @IBAction func seachButton(_ sender: UIButton) {
    }
    @IBAction func geoLocation(_ sender: UIButton) {
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self

        
    }

}

