//
//  Person+Convenience.swift
//  SecretSanta
//
//  Created by Jordan Furr on 4/10/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    
    @discardableResult
    convenience init(name: String, moc: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: moc)
        self.name = name
    }
}
