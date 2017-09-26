//
//  FavoritesViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
  var favoriteStore: FavoriteStore!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteStore.allFavorites.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
    let favorite = favoriteStore.allFavorites[indexPath.row]
    
    cell.textLabel?.text = favorite.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let favorite = favoriteStore.allFavorites[indexPath.row]
      favoriteStore.removeFavorite(favorite)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "ShowFavorite"?:
      let favorite: Favorite
      if let indexPath = tableView.indexPathForSelectedRow {
        favorite = favoriteStore.allFavorites[indexPath.row]
        let favoriteDetailViewController = segue.destination as! FavoriteDetailViewController
        favoriteDetailViewController.favorite = favorite
        favoriteDetailViewController.favoriteStore = favoriteStore
      }
    default:
      preconditionFailure("Unexpected segues identifier.")
    }
    
    
  }
}
