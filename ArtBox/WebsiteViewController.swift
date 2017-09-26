//
//  WebsiteViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController {
  var website: Website! {
    didSet {
      navigationItem.title = website.name
    }
  }
  var webView: WKWebView!
  var favoriteStore: FavoriteStore!
  
  @IBAction func favoriteButtonClicked(_ sender: UIBarButtonItem) {
    var favoriteName: String
    if let websiteTitle = self.webView.title, websiteTitle != "" {
      favoriteName = websiteTitle
    } else {
      favoriteName = website.name!
    }
    self.favoriteStore.createFavorite(name: favoriteName, url: self.webView.url!, websiteKey: website.websiteKey!, websiteName: website.name!)
  }
  
  override func viewDidLoad() {
    webView = WKWebView()
    view = webView
    
    let myRequest = URLRequest(url: website.url!)
    webView.load(myRequest)
  }
  
  
}
