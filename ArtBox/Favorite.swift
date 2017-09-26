//
//  Favorite.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class Favorite: NSObject, NSCoding {
  var name: String?
  var url: URL?
  var favoriteKey: String?
  var websiteKey: String?
  var websiteName: String?
  
  init(name: String, url: URL, websiteKey: String, websiteName: String) {
    self.name = name
    self.url = url
    self.favoriteKey = UUID().uuidString
    self.websiteKey = websiteKey
    self.websiteName = websiteName
    
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String?
    url = aDecoder.decodeObject(forKey: "url") as! URL?
    favoriteKey = aDecoder.decodeObject(forKey: "favoriteKey") as! String?
    websiteKey = aDecoder.decodeObject(forKey: "websiteKey") as! String?
    websiteName = aDecoder.decodeObject(forKey: "websiteName") as! String?
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(url, forKey: "url")
    aCoder.encode(favoriteKey, forKey: "favoriteKey")
    aCoder.encode(websiteKey, forKey: "websiteKey")
    aCoder.encode(websiteName, forKey: "websiteName")
  }
}
