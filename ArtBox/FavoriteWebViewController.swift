//
//  FavoriteWebViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit
import WebKit

class FavoriteWebViewController: UIViewController {
  var favorite: Favorite! {
    didSet {
      navigationItem.title = favorite.name
    }
  }
  
  var webView: WKWebView!
  
  override func viewDidLoad() {
    webView = WKWebView()
    view = webView
    
    let myRequest = URLRequest(url: favorite.url!)
    webView.load(myRequest)
  }
  
  
}
