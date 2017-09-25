//
//  Supply.swift
//  ArtBox
//
//  Created by Anna Chan on 9/25/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class Supply: NSObject {
  var name: String?
  var amount: Double? = 0.0
  let supplyKey: String?
  
  init(name: String, amount: Double) {
    self.name = name
    self.amount = amount
    self.supplyKey = UUID().uuidString
    
    super.init()
  }
  
  init(name: String, amount: Double, supplyKey: String) {
    self.name = name
    self.amount = amount
    self.supplyKey = supplyKey
    
    super.init()
  }
  
  convenience override init() {
    self.init(name: "", amount: 0.0)
  }
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String?
    amount = aDecoder.decodeObject(forKey: "amount") as! Double?
    supplyKey = aDecoder.decodeObject(forKey: "supplyKey") as! String?
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(amount, forKey: "amount")
    aCoder.encode(supplyKey, forKey: "supplyKey")
  }
  
}
