//
//  CurrentWeatherLoader.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 26.07.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Foundation

class CurrentWeatherLoader {
    
    class func loadWeather(completion: @escaping (WeatherMain?, Wind?, Cloudiness?, WeatherInfo?, WeatherDescription?) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=524894&appid=a5a5b41c22e74644d791ae3469fbc95e&lang=ru&units=metric")!
        
        let request = URLRequest(url: url)
     
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                
                // MARK: - Parsing
                
                // Dictionaries Parsing
                var weatherMain: WeatherMain?
                var wind: Wind?
                var cloudiness: Cloudiness?
                
                for (_, data) in jsonDict where data is NSDictionary {
                    
                    if let weatherMainTemp = WeatherMain(data: data as! NSDictionary) {
                        weatherMain = weatherMainTemp
                        print("WeatherMain ok.")
                    }
                    if let windTemp = Wind(data: data as! NSDictionary) {
                        wind = windTemp
                        print("Wind ok.")
                    }
                    if let cloudinessTemp = Cloudiness(data: data as! NSDictionary) {
                        cloudiness = cloudinessTemp
                        print("Cloudiness ok.")
                    }
                }
                
                // Basic Values Parsing
                var weatherInfo: WeatherInfo?
                if let cityName = jsonDict["name"] as? String, let visibility = jsonDict["visibility"] as? Int {
                    weatherInfo = WeatherInfo(cityName: cityName, visibility: visibility)
                    print("WeatherInfo ok.")
                }
                
                // Array parsing
                var weatherDescription: WeatherDescription?
                if let description = jsonDict["weather"] as? NSArray, let firstEL = description[0] as? NSDictionary, let fullDescription = firstEL["description"] as? String, let weatherIcon = firstEL["icon"] as? String {
                    weatherDescription = WeatherDescription(fullWeatherCondition: fullDescription, weatherIcon: weatherIcon)
                    print("WeatherDescription ok.")
                }
                DispatchQueue.main.async {
                    completion(weatherMain, wind, cloudiness, weatherInfo, weatherDescription)
                }
            }
        }
        task.resume()
    }
}
