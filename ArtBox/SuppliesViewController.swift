//
//  SuppliesViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/25/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class SuppliesViewController: UITableViewController {
  var supplyStore: SupplyStore!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return supplyStore.allSupplies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SupplyCell", for: indexPath)
    let supply = supplyStore.getAllSortedSupplies()[indexPath.row]
    
    cell.textLabel?.text = supply.name
    cell.detailTextLabel?.text = "\(supply.amount ?? 0.0)"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let supply = supplyStore.getAllSortedSupplies()[indexPath.row]
      supplyStore.removeSupply(supply)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "addSupply"?:
      let supply = supplyStore.createSupply(name: "", amount: 0.0)
      let supplyDetailViewController = segue.destination as! SupplyDetailViewController
      supplyDetailViewController.supply = supply
      supplyDetailViewController.supplyStore = supplyStore
    case "updateSupply"?:
      let supply: Supply
      if let indexPath = tableView.indexPathForSelectedRow {
        supply = supplyStore.getAllSortedSupplies()[indexPath.row]
        let supplyDetailViewController = segue.destination as! SupplyDetailViewController
        supplyDetailViewController.supply = supply
        supplyDetailViewController.supplyStore = supplyStore
      }
    default:
      preconditionFailure("Unexpected segues identifier.")
    }
    
    
  }
  
}
