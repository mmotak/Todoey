//
//  CategoriesTableViewController.swift
//  Todoey
//
//  Created by Maciej Motak on 23/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import UIKit

class CategoriesTVController: UITableViewController {
    private static let ITEMS : String = "goToItems"
    let categorySource = CategoryDbSource()
    
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
        return categorySource.size()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryItemCell", for: indexPath)
        let item = categorySource.getItem(at: indexPath.row)
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    
    //MARK - TABLE VIEW SELECT ROW
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        let item = categorySource.getItem(at: indexPath.row)
//        item.done = !item.done
//        
//        categorySource.update()
        performSegue(withIdentifier: CategoriesTVController.ITEMS, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == CategoriesTVController.ITEMS) {
            let itemsController = segue.destination as! ItemTVController
            
            if let index = tableView.indexPathForSelectedRow {
                itemsController.categoryDb = categorySource.getItem(at: index.row)
            }
        }
    }
    
    func addNewItem(withTitle title: String) {
        categorySource.add(withTitle: title)
        tableView.reloadData()
    }
    
    func reloadData(query : String? = nil) {
        categorySource.loadAll(query: query)
        tableView.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let textField = alert.textFields![0] as UITextField
            let text = textField.text
            if !(text?.isEmpty)! {
                self.addNewItem(withTitle: textField.text!)
            }
        })
        
        alert.addTextField { (textField) in
            textField.placeholder = "Put new category here"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
