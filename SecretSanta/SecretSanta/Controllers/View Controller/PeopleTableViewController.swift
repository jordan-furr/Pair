//
//  PeopleTableViewController.swift
//  SecretSanta
//
//  Created by Jordan Furr on 4/10/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    var peopleArray = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomTapped(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        randomTapped(true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       1
    }

    func getnumGroups() -> Int {
         let count = PersonController.shared.people.count
               return Int(ceil(Double(count)/2.0))
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = PersonController.shared.people[indexPath.row]
        cell.textLabel?.text = person.name
        return cell
    }
    
    //MARK: - Helpers
    @IBAction func randomTapped(_ sender: Any) {
       // peopleArray = PersonController.shared.people
        //peopleArray = peopleArray.shuffled()
        print("random tapped!")
        tableView.reloadData()
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Person", message: "Please add person to participate in pairs", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter new person's name"
        }
        let saveAction = UIAlertAction(title: "Add Person", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text != nil {
                    let newName = textField.text
                    PersonController.shared.createPerson(name: newName ?? "")
                    self.tableView.reloadData()
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated:  true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = PersonController.shared.people[indexPath.row]
            PersonController.shared.deletePerson(person: person)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           switch(section){
           case 0:
               return "Group \(1)"
           default:
               return "Group \(section + 1)"
           }
       }
    */
}
