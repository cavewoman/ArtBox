//
//  CategoryStore.swift
//  ArtBox
//
//  Created by Anna Chan on 9/27/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class CategoryStore {
  var allCategories = [Category]()
  
  let categoryArchiveURL: URL = {
    let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("categories.archive")
  }()
  
  init() {
    if let archivedCategories = NSKeyedUnarchiver.unarchiveObject(withFile: categoryArchiveURL.path) as? [Category] {
      allCategories = archivedCategories
    }
  }
  
  @discardableResult func createCategory(name: String, numOfSupplies: Int, supplies: [Supply]) -> Category {
    let newCategory = Category(name: name, numOfSupplies: numOfSupplies, supplies: supplies)
    allCategories.append(newCategory)
    return newCategory
  }
  
  func findCategory(byKey key: String) -> Category? {
    var category = allCategories.filter { $0.categoryKey == key }
    if category.isEmpty {
      return nil
    } else {
      return category[0]
    }
  }
  
  func findCategory(byName name: String) -> Category? {
    var category = allCategories.filter { $0.name == name }
    if category.isEmpty {
      return nil
    } else {
      return category[0]
    }
  }

  func removeCategory(_ category: Category) {
    if let index = allCategories.index(of: category) {
      allCategories.remove(at: index)
    }
  }
  
  func moveCategory(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return
    }
    
    let movedCategory = allCategories[fromIndex]
    allCategories.remove(at: fromIndex)
    allCategories.insert(movedCategory, at: toIndex)
  }
  
  func saveChanges() -> Bool {
    print("Saving categories to: \(categoryArchiveURL.path)")
    return NSKeyedArchiver.archiveRootObject(allCategories, toFile: categoryArchiveURL.path)
  }
}
