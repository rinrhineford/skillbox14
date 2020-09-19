//
//  ViewController.swift
//  Skillbox HW 14
//
//  Created by Nikita Selianin on 28.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBAction func lastNameInputDidEnd(_ sender: Any) {
        UserDefaultsPersistance.shared.lastName = lastNameTextField.text
    }
    @IBAction func firstNameInputDidEnd(_ sender: Any) {
        UserDefaultsPersistance.shared.firstName = firstNameTextField.text
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stylizeTextField(textField: lastNameTextField, placeholderText: "Фамилия")
        stylizeTextField(textField: firstNameTextField, placeholderText: "Имя")
        
        lastNameTextField.text = UserDefaultsPersistance.shared.lastName
        firstNameTextField.text = UserDefaultsPersistance.shared.firstName
    }
}

