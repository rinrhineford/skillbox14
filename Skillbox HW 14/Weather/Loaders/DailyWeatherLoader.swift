//
//  DailyWeatherLoader.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 03.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Alamofire

class DailyWeatherLoader {
    
    class func loadDailyForecast(completion: @escaping ([DailyWeatherModel]) -> Void) {
        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.75&lon=37.62&exclude=hourly,minutely,current&appid=a5a5b41c22e74644d791ae3469fbc95e&lang=ru&units=metric").responseJSON { responce in
            if let dailyForecasts = responce.value, let jsonDict = dailyForecasts as? NSDictionary {
                var dailyWeatherDataArray: [DailyWeatherModel] = []
                if let dailyWeatherData = jsonDict["daily"] as? NSArray {
                    for (index, el) in dailyWeatherData.enumerated() {
                        
                        guard index != 0 else { continue }
                        
                        if let dailyForecast = DailyWeatherModel(data: el as! NSDictionary) {
                            dailyWeatherDataArray.append(dailyForecast)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(dailyWeatherDataArray)
                    }
                }
            }
        }
    }
}
