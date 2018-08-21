//
//  ViewController.swift
//  Todoey
//
//  Created by Maciej Motak on 19/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import UIKit

class ItemTVController: UITableViewController {
    //let todoDataSource = DataSource.withCoreData()
    var todoDataSource : RealmItemDBSource?
    var categoryDb : RCategory? {
        didSet {
            todoDataSource = MainDataSource.INSTANCE.realm.itemDBSource(categoryDb!)
        }
    }
    
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
        return todoDataSource?.size() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = todoDataSource?.getItem(at: indexPath.row)
        
        cell.textLabel?.text = item?.title
        cell.accessoryType = (item?.done)! ? .checkmark : .none
        
        return cell
    }
    

    //MARK - TABLE VIEW SELECT ROW
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
//        let item = todoDataSource?.getItem(at: indexPath.row)
//        item?.done = !(item?.done)!
        
        let item = todoDataSource?.update(at: indexPath.row)
        
        cell?.accessoryType = (item?.done)! ? .checkmark : .none
        //todoDataSource?.update()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new to do", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let textField = alert.textFields![0] as UITextField
            let text = textField.text
            if !(text?.isEmpty)! {
                self.addNewItem(withTitle: textField.text!)
            }
        })
        
        alert.addTextField { (textField) in
            textField.placeholder = "Put new item here"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func addNewItem(withTitle title: String) {
        todoDataSource?.add(withTitle: title)
        tableView.reloadData()
    }
    
    func reloadData(query : String? = nil) {
        todoDataSource?.loadAll(query: query)
        tableView.reloadData()
    }
}

extension ItemTVController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        reloadData(query: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0) {
            reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            reloadData(query: searchBar.text)
        }
    }
}















//eof
