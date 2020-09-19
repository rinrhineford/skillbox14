//
//  WeatherPicsDict.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 27.07.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

let weatherPicsDict: [String:String] = [
    "": "",
    "01d":"sun.max",
    "01n":"moon.stars",
    "02d":"cloud.sun",
    "02n":"cloud.moon",
    "03d":"cloud",
    "03n":"cloud",
    "04d":"cloud",
    "04n":"cloud",
    "09d":"cloud.heavyrain",
    "09n":"cloud.heavyrain",
    "10d":"cloud.sun.rain",
    "10n":"cloud.moon.rain",
    "11d":"cloud.sun.bolt",
    "11n":"cloud.moon.bolt",
    "13d":"snow",
    "13n":"snow",
    "50d":"cloud.fog",
    "50n":"cloud.fog"
]

let weatherColorDict: [String:UIColor] = [
    "": .white,
    "01d": .systemYellow,
    "01n": .systemIndigo,
    "02d": .systemYellow,
    "02n": .systemIndigo,
    "03d": .systemBlue,
    "03n": .systemIndigo,
    "04d": .systemBlue,
    "04n": .systemIndigo,
    "09d": .systemBlue,
    "09n": .systemIndigo,
    "10d": .systemTeal,
    "10n": .systemPurple,
    "11d": .systemOrange,
    "11n": .systemPurple,
    "13d": .systemTeal,
    "13n": .systemIndigo,
    "50d": .systemGray,
    "50n": .darkGray
]

let monthsDict: [String: String] = [
    "": "Месяц",
    "Jan": "января",
    "Feb": "февраля",
    "Mar": "марта",
    "Apr": "апреля",
    "May": "мая",
    "Jun": "июня",
    "Jul": "июля",
    "Aug": "августа",
    "Sep": "сентября",
    "Oct": "октября",
    "Nov": "ноября",
    "Dec": "декабря"
]
