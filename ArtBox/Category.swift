//
//  Category.swift
//  ArtBox
//
//  Created by Anna Chan on 9/27/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class Category: NSObject, NSCoding {
  var name: String?
  var numOfSupplies: Int?
  var supplies = [Supply]()
  var categoryKey: String?
  
  init(name: String, numOfSupplies: Int, supplies: [Supply]) {
    self.name = name
    self.numOfSupplies = numOfSupplies
    self.supplies = supplies
    self.categoryKey = UUID().uuidString
    
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String?
    numOfSupplies = aDecoder.decodeObject(forKey: "numOfSupplies") as! Int?
    supplies = aDecoder.decodeObject(forKey: "supplies") as! [Supply]
    categoryKey = aDecoder.decodeObject(forKey: "categoryKey") as! String?
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(numOfSupplies, forKey: "numOfSupplies")
    aCoder.encode(supplies, forKey: "supplies")
    aCoder.encode(categoryKey, forKey: "categoryKey")
  }
  
  func removeSupply(supply: Supply) {
    if let index = self.supplies.index(of: supply) {
      self.supplies.remove(at: index)
    }
  }
  
}
