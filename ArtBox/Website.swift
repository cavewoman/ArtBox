//
//  Website.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class Website: NSObject {
  var name: String?
  var url: URL?
  var websiteKey: String?
  
  init(name: String, url: URL) {
    self.name = name
    self.url = url
    self.websiteKey = UUID().uuidString
    
    super.init()
  }
  
  init(name: String, url: URL, websiteKey: String) {
    self.name = name
    self.url = url
    self.websiteKey = websiteKey
    
    super.init()
  }
  
  convenience init(url: URL) {
    let nameFromUrl = url.path.components(separatedBy: ".")[0]
    self.init(name: nameFromUrl, url: url)
  }
  
  convenience override init() {
    self.init(name: "", url: URL(string: "www.example.com")!)
  }
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String?
    url = aDecoder.decodeObject(forKey: "url") as! URL?
    websiteKey = aDecoder.decodeObject(forKey: "websiteKey") as! String?
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(url, forKey: "url")
    aCoder.encode(websiteKey, forKey: "websiteKey")
  }
  
}
