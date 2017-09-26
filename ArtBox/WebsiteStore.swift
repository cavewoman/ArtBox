//
//  WebsiteStore.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class WebsiteStore {
  var allWebsites = [Website]()
  
  let websiteArchiveURL: URL = {
    let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("websites.archive")
  }()
  
  init() {
    if let archivedWebsites = NSKeyedUnarchiver.unarchiveObject(withFile: websiteArchiveURL.path) as? [Website] {
      allWebsites = archivedWebsites
    }
  }
  
  @discardableResult func createWebsite() -> Website {
    let newWebsite = Website()
    allWebsites.append(newWebsite)
    return newWebsite
  }
  
  @discardableResult func createWebsite(url: URL) -> Website {
    let newWebsite = Website(url: url)
    allWebsites.append(newWebsite)
    return newWebsite
  }
  
  @discardableResult func createWebsite(name: String, url: URL) -> Website {
    let newWebsite = Website(name: name, url: url)
    allWebsites.append(newWebsite)
    return newWebsite
  }
  
  @discardableResult func createWebsite(name: String, url: URL, websiteKey: String) -> Website {
    let newWebsite = Website(name: name, url: url, websiteKey: websiteKey)
    allWebsites.append(newWebsite)
    return newWebsite
  }
  
  func findWebsite(byKey key: String) -> Website? {
    var website = allWebsites.filter { $0.websiteKey == key }
    if website.isEmpty {
      return nil
    } else {
      return website[0]
    }
  }
  
  func removeWebsite(_ website: Website) {
    if let index = allWebsites.index(of: website) {
      allWebsites.remove(at: index)
    }
  }
  
  func moveWebsite(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex { return }
    let movedWebsite = allWebsites[fromIndex]
    allWebsites.remove(at: fromIndex)
    allWebsites.insert(movedWebsite, at: toIndex)
  }
  
  func saveChanges() -> Bool {
    print("Saving websites to: \(websiteArchiveURL.path)")
    return NSKeyedArchiver.archiveRootObject(allWebsites, toFile: websiteArchiveURL.path)
  }
  
}
