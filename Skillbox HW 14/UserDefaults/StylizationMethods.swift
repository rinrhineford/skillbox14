//
//  StylizationMethods.swift
//  Skillbox HW 14
//
//  Created by Nikita Selianin on 28.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

func stylizeTextField(textField: UITextField, placeholderText: String?) {
    textField.attributedPlaceholder = NSAttributedString(string: placeholderText ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
}
