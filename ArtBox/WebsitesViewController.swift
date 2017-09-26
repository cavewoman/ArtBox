//
//  WebsitesViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/26/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class WebsitesViewController: UITableViewController {
  var websiteStore: WebsiteStore!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return websiteStore.allWebsites.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath)
    let website = websiteStore.allWebsites[indexPath.row]
    
    cell.textLabel?.text = website.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let website = websiteStore.allWebsites[indexPath.row]
      websiteStore.removeWebsite(website)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "AddWebsite"?:
      let website = websiteStore.createWebsite()
      let websiteDetailViewController = segue.destination as! WebsiteDetailViewController
      websiteDetailViewController.website = website
      websiteDetailViewController.websiteStore = websiteStore
    case "UpdateWebsite"?:
      let website: Website
      if let indexPath = tableView.indexPathForSelectedRow {
        website = websiteStore.allWebsites[indexPath.row]
        let websiteDetailViewController = segue.destination as! WebsiteDetailViewController
        websiteDetailViewController.website = website
        websiteDetailViewController.websiteStore = websiteStore
      }
    default:
      preconditionFailure("Unexpected segues identifier.")
    }
    
    
  }

  
}
