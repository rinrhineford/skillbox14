//
//  DailyTableCell.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 02.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

class DailyTableCell: UITableViewCell {

    @IBOutlet weak var dayIndicatorLabel: UILabel!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var temperatureIndicatorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
