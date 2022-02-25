//
//  TodoTableViewController.swift
//  CoreDataTest
//
//  Created by Hwang on 2022/02/26.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController {
    
    var arrayItems: [Item] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = arrayItems[indexPath.row].name
        cell.contentConfiguration = content
        
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.name = textField.text!
            
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new"
        }
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem() {
        do {
            try context.save()
        }
        catch {
            print("Error saving Item, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItem() {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            arrayItems = try context.fetch(request)
        }
        catch {
            print("Error fetching data from Item, \(error)")
        }
        tableView.reloadData()
    }
}
