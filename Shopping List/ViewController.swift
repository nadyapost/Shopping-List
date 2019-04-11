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
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTaped))
 
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
    present(ac, animated: true) {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
      ac.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
    }
  }
  @objc func dismissAlertController(){
    self.dismiss(animated: true, completion: nil)

  }
  func addNewItemToList(_ item:  String) {
    if !item.isEmpty{
    shoppingList.insert(item, at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
    }

  }
  
  @objc func shareTaped() {
    let list = shoppingList.joined(separator: "\n")
    let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
    
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }
  
}

