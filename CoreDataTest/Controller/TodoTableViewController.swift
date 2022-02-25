//
//  TodoTableViewController.swift
//  CoreDataTest
//
//  Created by Hwang on 2022/02/26.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController {
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
}
