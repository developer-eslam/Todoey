//
//  TodoListViewCotroller.swift
//  Todoey
//
//  Created by Eslam Abotaleb on 5/10/19.
//  Copyright © 2019 Eslam Abotaleb. All rights reserved.
//

import UIKit

class TodoListViewCotroller: UITableViewController {

    var itemarray = [Item]()
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let defaults = UserDefaults.standard
    @IBAction func addbtnPressed(_ sender: Any) {
        
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: " ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            self.itemarray.append(textfield.text!)
            let newitem = Item()
            newitem.title = textfield.text!
//            self.defaults.set(self.itemarray, forKey: "ItemsData")
            self.itemarray.append(newitem)

          self.saveItems()
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "Create New Item"
            textfield = alerttextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemarray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error If Occured")
        }
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

       
        print(dataFilePath)
//        let item = Item()
//        item.title = "Find Milk"
//        itemarray.append(item)
//        let newItem = Item()
//        newItem.title = "Any More"
//
//        let newItem2 = Item()
//        newItem2.title = "Any Data"
        
//        if let  item = defaults.array(forKey: "ItemsData") as? [Item] {
//            itemarray = item
//        }
        
        loadItems()
    }

    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decode = PropertyListDecoder()
            do {
                itemarray = try decode.decode([Item].self, from: data)
            } catch {
                print("Error decode")
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemarray[indexPath.row].done = !itemarray[indexPath.row].done
        
//        if itemarray[indexPath.row].done == false {
//           itemarray[indexPath.row].done = true
//        } else { itemarray[indexPath.row].done = false }
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        }
       
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoelist")
        cell!.textLabel?.text = itemarray[indexPath.row].title
//        if itemarray[indexPath.row].done == true {
//            cell!.accessoryType = .checkmark
//        } else {
//            cell!.accessoryType = .none
//        }
        cell?.accessoryType = itemarray[indexPath.row].done ? .checkmark : .none
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(itemarray.count)
        return itemarray.count
    }

    
}
