//
//  SupplyDetailViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/25/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import Foundation
import UIKit

class SupplyDetailViewController: UIViewController {
  @IBOutlet var nameField: UITextField!
  @IBOutlet var amountField: UITextField!
  
  var supply: Supply! {
    didSet {
      navigationItem.title = supply.name
    }
  }
  
  var supplyStore: SupplyStore!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let supplyName = supply.name {
      nameField.text = supplyName
    }
    
    if let supplyAmount = supply.amount {
      amountField.text = "\(supplyAmount)"
    }
   }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if let enteredName = nameField.text, enteredName != "" {
      supply.name = nameField.text
      supply.amount = Double(amountField.text!) ?? 0.0
    } else {
      supplyStore.removeSupply(supply)
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}
