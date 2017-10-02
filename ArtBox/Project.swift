//
//  Project.swift
//  ArtBox
//
//  Created by Anna Chan on 10/2/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class Project : NSObject {
  var name: String?
  var date: Date?
  let imageKey: String?
  
  init(name: String, date: Date) {
    self.name = name
    self.date = date
    self.imageKey = UUID().uuidString
    
    super.init()
  }
  
  init(name: String, date: Date, imageKey: String) {
    self.name = name
    self.date = date
    self.imageKey = imageKey
    
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: "name") as! String?
    self.date = aDecoder.decodeObject(forKey: "date") as! Date?
    self.imageKey = aDecoder.decodeObject(forKey: "image") as! String?
    
    super.init()
  }
  
  func encoder(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "name")
    aCoder.encode(self.date, forKey: "date")
    aCoder.encode(self.imageKey, forKey: "imageKey")
  }
}
