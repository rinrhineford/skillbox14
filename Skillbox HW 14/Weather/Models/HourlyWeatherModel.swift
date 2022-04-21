//
//  HourlyWeatherModel.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 29.07.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Foundation
class HourlyWeatherModel {
    
    let hour: Double
    let hourTemperature: Double
    let basicProperties: NSArray
    let hourWeatherConditionIcon: String?
        
    init? (data: NSDictionary) {
        guard let hour = data["dt"] as? Double else { print("dt wrong"); return nil }
           guard let hourTemperature = data["temp"] as? Double else { print("temp wrong"); return nil }
           guard let basicProperties = data["weather"] as? NSArray else { print("weather wrong"); return nil }
        self.hour = hour
        self.hourTemperature = hourTemperature
        self.basicProperties = basicProperties
        let aaa = basicProperties[0] as? NSDictionary
        self.hourWeatherConditionIcon = aaa?["icon"] as? String
        }
    }
