//
//  File.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 29.07.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Foundation

class HourlyWeatherLoader {
    
    class func loadWeather(completion: @escaping ([HourlyWeatherModel]) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.75&lon=37.62&exclude=daily&appid=a5a5b41c22e74644d791ae3469fbc95e&lang=ru&units=metric")!
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments), let jsonDict = json as? NSDictionary {
                print(jsonDict)
                // MARK: - Parsing
                var hourlyWeatherDataArray: [HourlyWeatherModel] = []
                if let hourlyWeatherData = jsonDict["hourly"] as? NSArray {
                    for (index, el) in hourlyWeatherData.enumerated() {

                        guard index != 0 else { continue }
                        
                        if let hourForecast = HourlyWeatherModel(data: el as! NSDictionary) {
                            hourlyWeatherDataArray.append(hourForecast)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(hourlyWeatherDataArray)
                    }
                }
            }
        }
        task.resume()
    }
}
