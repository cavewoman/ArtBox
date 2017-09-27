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
  var supplyImageStore: SupplyImageStore!
  var categoryStore: CategoryStore!
  
  enum SupplyAmount {
    case moreThanHalfFull
    case halfFull
    case lessThanHalfFull
    case empty
  }
  
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
    setBackgoundColor(cell: cell, amount: supply.amount!)
    
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
      let supply = supplyStore.createSupply(name: "", amount: 0.0, categoryName: "")
      let supplyDetailViewController = segue.destination as! SupplyDetailViewController
      supplyDetailViewController.supply = supply
      supplyDetailViewController.supplyStore = supplyStore
      supplyDetailViewController.supplyImageStore = supplyImageStore
      supplyDetailViewController.categoryStore = categoryStore
    case "updateSupply"?:
      let supply: Supply
      if let indexPath = tableView.indexPathForSelectedRow {
        supply = supplyStore.getAllSortedSupplies()[indexPath.row]
        let supplyDetailViewController = segue.destination as! SupplyDetailViewController
        supplyDetailViewController.supply = supply
        supplyDetailViewController.supplyStore = supplyStore
        supplyDetailViewController.supplyImageStore = supplyImageStore
        supplyDetailViewController.categoryStore = categoryStore
      }
    default:
      preconditionFailure("Unexpected segues identifier.")
    }
    
    
  }
  
  func setBackgoundColor(cell: UITableViewCell, amount: Double){
    switch getAmountType(amount: amount) {
    case .moreThanHalfFull:
      cell.backgroundColor = UIColor().colorFromHex(hexValue: "35226a")
    case .halfFull:
      cell.backgroundColor = UIColor().colorFromHex(hexValue: "613dc1")
    case .lessThanHalfFull:
      cell.backgroundColor = UIColor().colorFromHex(hexValue: "c7c9f2")
    default:
      cell.backgroundColor = UIColor().colorFromHex(hexValue: "ffffff")
      
    }
  }
  
  func getAmountType(amount: Double?) -> SupplyAmount {
    if let amount = amount {
      if amount > 0.5 {
        return .moreThanHalfFull
      } else if amount == 0.5 {
        return .halfFull
      } else if (amount > 0) && (amount < 0.5) {
        return .lessThanHalfFull
      } else {
        return .empty
      }
    } else {
      return .empty
    }
  }
  
}


extension UIColor {
  func colorFromHex(hexValue: String) -> UIColor {
    let (redText, greenText, blueText) = parseHexString(hexValue: hexValue)
    
    let redFloat = Float(redText)
    let greenFloat = Float(greenText)
    let blueFloat = Float(blueText)
    
    let red: Float = redFloat! / 0xff
    let green: Float = greenFloat! / 0xff
    let blue: Float = blueFloat! / 0xff
    
    return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: 1)
  }
  
  func parseHexString(hexValue: String) -> (String, String, String) {
    var redText: String = "0x"
    var greenText: String = "0x"
    var blueText: String = "0x"
    
    for (index, char) in hexValue.characters.enumerated() {
      switch index {
      case 0, 1:
        redText += "\(char)"
      case 2, 3:
        greenText += "\(char)"
      default:
        blueText += "\(char)"
      }
    }
    return (redText, greenText, blueText)
  }
}
