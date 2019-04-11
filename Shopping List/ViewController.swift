//
//  ViewController.swift
//  Shopping List
//
//  Created by Nadya Postriganova on 10/4/19.
//  Copyright © 2019 Nadya Postriganova. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  var shoppingList: [String] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
 
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoppingList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = shoppingList[indexPath.row]
    return cell
  }
  
  @objc func addNewItem() {
    let ac = UIAlertController(title: "New item", message: nil, preferredStyle: .alert)
    ac.addTextField()
    let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
      guard let item = ac?.textFields?[0].text else { return }
      self?.addNewItemToList(item)
    }
    ac.addAction(submitAction)
    present(ac, animated: true)

  }
  func addNewItemToList(_ item:  String) {
    shoppingList.insert(item, at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)

  }
}

