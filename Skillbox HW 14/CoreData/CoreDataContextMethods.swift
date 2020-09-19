//
//  CoreDataContextMethods.swift
//  Skillbox HW 14
//
//  Created by Nikita Selianin on 10.09.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func connectContext() -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    return context
}

func saveContext(context: NSManagedObjectContext) {
    do {
        try context.save()
    } catch let error as NSError {
        print("\(error), userInfo \(error.userInfo)")
    }
}
