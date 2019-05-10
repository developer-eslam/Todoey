//
//  TodoListViewCotroller.swift
//  Todoey
//
//  Created by Eslam Abotaleb on 5/10/19.
//  Copyright © 2019 Eslam Abotaleb. All rights reserved.
//

import UIKit

class TodoListViewCotroller: UITableViewController {

    var itemarray = ["First", "Second", "Third"]
    
    let defaults = UserDefaults.standard
    @IBAction func addbtnPressed(_ sender: Any) {
        
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: " ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemarray.append(textfield.text!)
            self.defaults.set(self.itemarray, forKey: "ItemsData")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "Create New Item"
            textfield = alerttextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let  item = defaults.array(forKey: "ItemsData") as? [String] {
            itemarray = item
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
       
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoelist")
        cell!.textLabel?.text = itemarray[indexPath.row]
        return cell!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    }

    
}
