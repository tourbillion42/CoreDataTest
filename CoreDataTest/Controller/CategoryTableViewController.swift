//
//  CategoryTableViewController.swift
//  CoreDataTest
//
//  Created by Hwang on 2022/02/25.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categories = [Catego]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
