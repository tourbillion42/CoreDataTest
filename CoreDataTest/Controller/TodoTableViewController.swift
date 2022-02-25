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
    
}
