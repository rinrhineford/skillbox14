//
//  UserDefaultsPersistance.swift
//  Skillbox HW 14
//
//  Created by Nikita Selianin on 28.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Foundation

class UserDefaultsPersistance {
    static let shared = UserDefaultsPersistance()
    
    private let kFirstNameKey = "UserDefaultsPersistance.kFirstNameKey"
    private let kLastNameKey = "UserDefaultsPersistance.kLastNameKey"
    
    var firstName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kFirstNameKey) }
        get { return UserDefaults.standard.string(forKey: kFirstNameKey) }
    }
    
    var lastName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kLastNameKey) }
        get { return UserDefaults.standard.string(forKey: kLastNameKey) }
    }
}
