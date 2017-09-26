//
//  WebsiteDetailViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class WebsiteDetailViewController: UIViewController {
  @IBOutlet var nameField: UITextField!
  @IBOutlet var urlField: UITextField!
  @IBOutlet var visitSiteButton: UIButton!
  
  var website: Website! {
    didSet {
      navigationItem.title = website.name
    }
  }
  var websiteStore: WebsiteStore!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let websiteName = website.name {
      nameField.text = websiteName
    }
    
    if let websiteUrl = website.url, websiteUrl.absoluteString != "" && websiteUrl.absoluteString != "www.example.com" {
      urlField.text = websiteUrl.absoluteString
      visitSiteButton.isHidden = false
    } else {
      visitSiteButton.isHidden = true
    }
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if let enteredURL = urlField.text, enteredURL != "" && enteredURL != "www.example.com" {
      website.url = URL(string: enteredURL)
      if let enteredName = nameField.text, enteredName != "" {
        website.name = enteredName
      } else {
        website.name = enteredURL.components(separatedBy: ".")[0]
      }
    } else {
      websiteStore.removeWebsite(website)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "ShowWebsite"?:
      let websiteViewController = segue.destination as! WebsiteViewController
      websiteViewController.website = website
    default:
      preconditionFailure("Unexpected segues identifier")
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
