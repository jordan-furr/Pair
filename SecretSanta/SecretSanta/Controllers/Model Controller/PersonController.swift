//
//  PersonController.swift
//  SecretSanta
//
//  Created by Jordan Furr on 4/10/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    static let shared = PersonController()
    
    
    var people: [Person] {
        get {let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
            return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []}
    }
    
    func createPerson(name: String) {
        Person(name: name)
        saveToPersistenceStore()
    }
    
    /*
    func randomize(){
        let numGroups = Int(ceil(Double(people.count)/2.0))
        var newPpl: [Person] = []
        for i in 0..<numGroups {
            
            guard let person = people.popLast() else { return }
            person.groupIndex = String(i)
            newPpl.append(person)
            
            guard let partner = people.popLast() else { return }
            partner.groupIndex = String(i)
            newPpl.append(partner)
        }
        people = newPpl
        saveToPersistenceStore()
    }
 */
    
    func deletePerson(person: Person) {
        CoreDataStack.context.delete(person)
        saveToPersistenceStore()
    }
    
    func saveToPersistenceStore(){
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error saving the data!!!!! \(#function) \(error.localizedDescription)")
        }
    }}
