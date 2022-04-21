//
//  CalculatingMethods.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 06.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Foundation

func calculateTemperature(_ temp: Double?) -> String {
    let tempInt = Int(temp ?? 0)
    if tempInt > 0 { return "+\(tempInt)°" } else if tempInt < 0 { return "-\(tempInt)°"}
    else { return "0°" }
}

func calculateDate(_ unixDate: Double?) -> [Substring] {
    let date = Date(timeIntervalSince1970: unixDate ?? 0.0)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.medium
    dateFormatter.dateStyle = DateFormatter.Style.medium
    dateFormatter.timeZone = .current
    let localDate = dateFormatter.string(from: date)
    let localDateArray = localDate.split(separator: " ")
    return localDateArray
}
