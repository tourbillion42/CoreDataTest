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
    
    var selectedCategory: Catego? {
        didSet {
            loadItem()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TodoItems"

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
            newItem.parentCategory = self.selectedCategory
            
            self.arrayItems.append(newItem)
            self.saveItem()
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
    
    func loadItem(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        }
        else {
            request.predicate = categoryPredicate
        }
        
        do {
            arrayItems = try context.fetch(request)
        }
        catch {
            print("Error fetching data from Item, \(error)")
        }
        tableView.reloadData()
    }
}

extension TodoTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItem(with: request, predicate: predicate)
        
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
