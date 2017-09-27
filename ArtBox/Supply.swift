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
  var categoryName: String?
  let supplyKey: String?
  
  init(name: String, amount: Double, categoryName: String) {
    self.name = name
    self.amount = amount
    self.categoryName = categoryName
    self.supplyKey = UUID().uuidString
    
    super.init()
  }
  
  init(name: String, amount: Double, categoryName: String, supplyKey: String) {
    self.name = name
    self.amount = amount
    self.categoryName = categoryName
    self.supplyKey = supplyKey
    
    super.init()
  }
  
  convenience override init() {
    self.init(name: "", amount: 0.0, categoryName: "")
  }
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String?
    amount = aDecoder.decodeObject(forKey: "amount") as! Double?
    categoryName = aDecoder.decodeObject(forKey: "categoryName") as! String?
    supplyKey = aDecoder.decodeObject(forKey: "supplyKey") as! String?
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(amount, forKey: "amount")
    aCoder.encode(categoryName, forKey: "categoryName")
    aCoder.encode(supplyKey, forKey: "supplyKey")
  }
  
}
