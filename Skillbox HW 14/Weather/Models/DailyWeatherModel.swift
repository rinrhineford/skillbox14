//
//  DailyWeatherModel.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 02.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Foundation

class DailyWeatherModel {
    
    let dailyTimeData: Double
    let dailyMinTemperature: Double
    let dailyMaxTemperatue: Double
    let dailyweatherConditionIcon: String?
    
    init? (data: NSDictionary) {
        guard let dailyTimeData = data["dt"] as? Double,
        let dailyTemperatureDict = data["temp"] as? NSDictionary,
        let dailyMainDataArray = data["weather"] as? NSArray else { print("Smth went wrong in progress of parcing daily weather"); return nil }
        self.dailyTimeData = dailyTimeData
        self.dailyMinTemperature = dailyTemperatureDict["min"] as? Double ?? 0.0
        self.dailyMaxTemperatue = dailyTemperatureDict["max"] as? Double ?? 0.0
        let insertedMainData = dailyMainDataArray[0] as? NSDictionary
        self.dailyweatherConditionIcon = insertedMainData?["icon"] as? String
    }
}
