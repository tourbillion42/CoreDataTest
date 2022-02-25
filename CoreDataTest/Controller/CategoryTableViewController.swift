//
//  CategoryTableViewController.swift
//  CoreDataTest
//
//  Created by Hwang on 2022/02/25.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categories = [Catego]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Category"
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = categories[indexPath.row].title
        cell.contentConfiguration = content
        
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Catego(context: self.context)
            newCategory.title = textField.text!
            
            self.categories.append(newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new"
        }
        present(alert, animated: true, completion: nil)
    }
    
}
