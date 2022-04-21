//
//  NotesTableViewCell.swift
//  Skillbox HW 14
//
//  Created by Nikita Selianin on 29.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var indicatorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
