//
//  FavoriteStore.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class FavoriteStore {
  var allFavorites = [Favorite]()
  
  let favoriteArchiveURL: URL = {
    let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("favorites.archive")
  }()
  
  init() {
    if let archivedFavorites = NSKeyedUnarchiver.unarchiveObject(withFile: favoriteArchiveURL.path) as? [Favorite] {
      allFavorites = archivedFavorites
    }
  }
  
  @discardableResult func createFavorite(name: String, url: URL, websiteKey: String, websiteName: String) -> Favorite {
    let newFavorite = Favorite(name: name, url: url, websiteKey: websiteKey, websiteName: websiteName)
    allFavorites.append(newFavorite)
    return newFavorite
  }
  
  func findFavorite(byKey key: String) -> Favorite? {
    var favorite = allFavorites.filter { $0.favoriteKey == key }
    if favorite.isEmpty {
      return nil
    } else {
      return favorite[0]
    }
  }
  
  func removeFavorite(_ favorite: Favorite) {
    if let index = allFavorites.index(of: favorite) {
      allFavorites.remove(at: index)
    }
  }
  
  func moveFavorite(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return
    }
    
    let movedFavorite = allFavorites[fromIndex]
    allFavorites.remove(at: fromIndex)
    allFavorites.insert(movedFavorite, at: toIndex)
  }
  
  func saveChanges() -> Bool {
    print("Saving favorites to: \(favoriteArchiveURL.path)")
    return NSKeyedArchiver.archiveRootObject(allFavorites, toFile: favoriteArchiveURL.path)
  }

}
