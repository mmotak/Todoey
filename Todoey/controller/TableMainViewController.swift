//
//  ViewController.swift
//  Todoey
//
//  Created by Maciej Motak on 19/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import UIKit

class TableMainViewController: UITableViewController {
    let todoDataSource = DataSource();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - TABLE VIEW DATA SOURCE
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataSource.size()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = todoDataSource.getItem(indexPath.row)
        
        cell.textLabel?.text = item.text
        cell.accessoryType = item.checked ? .checkmark : .none
        
        return cell
    }
    

    //MARK - TABLE VIEW SELECT ROW
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let item = todoDataSource.getItem(indexPath.row)
        item.checked = !item.checked
        
        cell?.accessoryType = item.checked ? .checkmark : .none
        todoDataSource.saveListToStorage()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new to do", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let textField = alert.textFields![0] as UITextField
            let text = textField.text
            if !(text?.isEmpty)! {
                self.addNewItem(ToDoItem(text: textField.text!, checked: false))
            }
        })
        
        alert.addTextField { (textField) in
            textField.placeholder = "Put new item here"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func addNewItem(_ item: ToDoItem) {
        todoDataSource.addNewItem(item)
        tableView.reloadData()
    }
}

