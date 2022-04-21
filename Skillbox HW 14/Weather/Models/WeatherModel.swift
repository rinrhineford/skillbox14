//
//  WeatherModel.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 26.07.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Foundation

class WeatherInfo {

    let cityName: String
    let visibility: Int
    
    init? (cityName: String, visibility: Int) {
        self.cityName = cityName
        self.visibility = visibility
    }
}

class WeatherDescription {
    let fullWeatherCondition: String
    let weatherIcon: String
    init? (fullWeatherCondition: String, weatherIcon: String) {
        self.fullWeatherCondition = fullWeatherCondition
        self.weatherIcon = weatherIcon
    }
}

class WeatherMain {
    let mainTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let feelsLike: Double
    let atmospherePressure: Int
    let humidity: Int
    
    init? (data: NSDictionary) {
        guard let mainTemperature = data["temp"] as? Double,
            let minTemperature = data["temp_min"] as? Double,
            let maxTemperature = data["temp_max"] as? Double,
            let feelsLike = data["feels_like"] as? Double,
            let atmospherePressure = data["pressure"] as? Int,
            let humidity = data["humidity"] as? Int else { return nil }
        self.mainTemperature = mainTemperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.feelsLike = feelsLike
        self.atmospherePressure = atmospherePressure
        self.humidity = humidity
    }
}

class Wind {
    let windSpeed: Double

    init? (data: NSDictionary) {
        guard let windSpeed = data["speed"] as? Double else { return nil }
        self.windSpeed = windSpeed
    }
}

class Cloudiness {
    let allCloudiness: Int
    
    init? (data: NSDictionary) {
        guard let allCloudiness = data["all"] as? Int else { return nil }
        self.allCloudiness = allCloudiness
    }
}
