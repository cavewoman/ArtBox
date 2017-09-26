//
//  FavoriteDetailViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
  @IBOutlet var nameField: UITextField!
  @IBOutlet var urlLabel: UILabel!
  @IBOutlet var websiteLabel: UILabel!
  
  
  var favorite: Favorite! {
    didSet {
      navigationItem.title = favorite.name
    }
  }
  var favoriteStore: FavoriteStore!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let favoriteName = favorite.name, favoriteName != "" {
      nameField.text = favoriteName
    }
    
    if let favoriteURL = favorite.url, favoriteURL.absoluteString != "" {
      urlLabel.text = favoriteURL.absoluteString
    }
    
    if let favoriteWebsiteName = favorite.websiteName, favoriteWebsiteName != "" {
      websiteLabel.text = favoriteWebsiteName
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if let enteredName = nameField.text, enteredName != "" {
      favorite.name = enteredName
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "ShowFavoriteWeb"?:
      let favoriteWebViewController = segue.destination as! FavoriteWebViewController
      favoriteWebViewController.favorite = favorite
    default:
      preconditionFailure("Unexpected segues identifier")
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

}
