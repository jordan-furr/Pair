//
//  PeopleTableViewController.swift
//  SecretSanta
//
//  Created by Jordan Furr on 4/10/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    //add button tapped
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
}
