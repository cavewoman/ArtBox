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
  
  override func viewDidLoad() {
    webView = WKWebView()
    view = webView
    
//    let myRequest = URLRequest(url: URL(string: "https://www.instagram.com")!)
    let myRequest = URLRequest(url: website.url!)
    webView.load(myRequest)
  }
  
  
}
