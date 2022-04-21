//
//  HourlyWeatherCell.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 30.07.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

@IBDesignable class HourlyWeatherCell: UITableViewCell {

    @IBOutlet weak var hourlyWeatherConditionImage: UIImageView!
    @IBOutlet weak var hourIndicator: UILabel!
    @IBOutlet weak var hourlyTemperatureAverageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
