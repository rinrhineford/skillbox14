//
//  MainWeatherViewController.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 06.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {

    @IBOutlet weak var mainWeatherConditionImage: UIImageView!
    @IBOutlet weak var mainTemperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
        
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var atmospherePressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
        
    @IBOutlet weak var nextHoursTableView: UITableView!
        
    var hours: [HourlyWeatherModel] = []
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeather()
        insertHourlyWeather()
        DailyWeatherLoader.loadDailyForecast { dailyForecasts in
            print(dailyForecasts.count)
            }
        }
        
    func insertHourlyWeather() {
        HourlyWeatherLoader.loadWeather() { hours in
            self.hours = hours
            self.nextHoursTableView.reloadData()
            }
        }
        
    func loadWeather() {
        CurrentWeatherLoader.loadWeather { weatherMain, wind, cloudiness, weatherInfo, weatherDescription in
        
            // Main Weather Condition Image
            self.mainWeatherConditionImage.image = UIImage.init(systemName: weatherPicsDict["\(weatherDescription?.weatherIcon ?? "")"] ?? "")
            self.mainWeatherConditionImage.tintColor = weatherColorDict["\(weatherDescription?.weatherIcon ?? "")"]
            
            // City Name
            self.cityLabel.text = weatherInfo?.cityName ?? "No data."
            
            // Current Weather
            self.mainTemperatureLabel.text = calculateTemperature(weatherMain?.mainTemperature)
            
            // Pressure
            let atmospherePressureText = Int(Double(weatherMain?.atmospherePressure ?? 0) / 1.33)
            self.atmospherePressureLabel.text = "🪐  Давление: \(atmospherePressureText) мм"
            
            // Weather Condition
            self.weatherConditionLabel.text = weatherDescription?.fullWeatherCondition
            
            // Min and Max Temperature
            let minTemperatureText = calculateTemperature(weatherMain?.minTemperature)
            let maxTemperatureText = calculateTemperature(weatherMain?.maxTemperature)
            self.minMaxTemperatureLabel.text = "\(minTemperatureText) ... \(maxTemperatureText)"
            
            // Wind Speed
            self.windSpeedLabel.text = "💨  Скорость: \(wind?.windSpeed ?? 0.0) м/с"
            
            // Visibility
            let visibilityText = "\(Double(weatherInfo?.visibility ?? 0) / 1000.0)"
            self.visibilityLabel.text = "👓  Видимость: \(visibilityText) км"
            
            // Feels like
            self.feelsLikeLabel.text = "🌡  Ощущается: \(calculateTemperature(weatherMain?.feelsLike))"
            
            // Humidity
            self.humidityLabel.text = "💧  Влажность: \(weatherMain?.humidity ?? 0)%"
        
            // Cloudiness
            self.cloudinessLabel.text = "☁️  Облачность: \(cloudiness?.allCloudiness ?? 0)%"
        }
    }
}


extension MainWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {            let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyWeatherCell") as! HourlyWeatherCell
        let hour = hours[indexPath.row]
        
        cell.hourlyTemperatureAverageLabel.text = calculateTemperature(hour.hourTemperature)
        cell.hourlyWeatherConditionImage.image = UIImage.init(systemName: weatherPicsDict["\(hour.hourWeatherConditionIcon ?? "")"] ?? "")
        cell.hourlyWeatherConditionImage.tintColor = weatherColorDict["\(hour.hourWeatherConditionIcon ?? "")"]
        
        // Time parsing
        let localDateArray = calculateDate(hour.hour)
        let currentTimeArray = localDateArray[4].split(separator: ":")
        var currentHour: Int? = Int(currentTimeArray[0])
            
        if localDateArray[5] == "PM" && currentHour == 12 {  }
        else if localDateArray[5] == "AM" && currentHour == 12 { currentHour = 0 } else if localDateArray[5] == "PM" {
            currentHour? += 12
        }
        cell.hourIndicator.text = "\(currentHour ?? 0)"
            
        return cell
    }
}
