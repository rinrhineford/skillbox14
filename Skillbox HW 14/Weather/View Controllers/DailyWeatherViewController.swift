//
//  DailyWeatherViewController.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 02.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

class DailyWeatherViewController: UIViewController {
    @IBOutlet weak var dailyWeatherTableView: UITableView!
    
    var days: [DailyWeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertDailyWeather()
        dailyWeatherTableView.rowHeight = (view.frame.inset(by: view.safeAreaInsets).height) / 8.2
    }
    
    func insertDailyWeather() {
    DailyWeatherLoader.loadDailyForecast { days in
        self.days = days
        self.dailyWeatherTableView.reloadData()
        }
    }
}

extension DailyWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell") as! DailyTableCell
        let day = days[indexPath.row]
        
        cell.temperatureIndicatorLabel.text = "\(calculateTemperature(day.dailyMinTemperature)) ... \(calculateTemperature(day.dailyMaxTemperatue))"
        cell.weatherConditionImageView.image = UIImage.init(systemName: weatherPicsDict["\(day.dailyweatherConditionIcon ?? "")"] ?? "")
        cell.weatherConditionImageView.tintColor = weatherColorDict["\(day.dailyweatherConditionIcon ?? "")"]
        
        let localDateArray = calculateDate(day.dailyTimeData)
        // Day Parsing
        var stringForecastDay: String? = String(localDateArray[1])
        if let i = stringForecastDay?.firstIndex(of: ",") {
            stringForecastDay?.remove(at: i)
        }
        
        // Month Parsing
        let stringForecastMonth: String? = String(localDateArray[0])
        cell.dayIndicatorLabel.text = "\(stringForecastDay ?? "0") \(monthsDict[stringForecastMonth ?? ""] ?? "")"
        return cell
        
    }
}
