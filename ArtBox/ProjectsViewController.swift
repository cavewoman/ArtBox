//
//  ProjectsViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 10/2/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController {
  var projectStore: ProjectStore!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return projectStore.allProjects.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath)
    let project = projectStore.getAllSortedProjects()[indexPath.row]
    
    cell.textLabel?.text = project.name
    cell.detailTextLabel?.text = "\(project.date ?? Date.init())"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let project = projectStore.getAllSortedProjects()[indexPath.row]
      projectStore.removeProject(project)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "addProject"?:
      let project = projectStore.createProject(name: "", date: Date.init(), imageKey: UUID.init().uuidString)
      let projectDetailViewController = segue.destination as! ProjectDetailViewController
      projectDetailViewController.project = project
      projectDetailViewController.projectStore = projectStore
    default:
      preconditionFailure("Unexpected segue identifier")
    }
  }
}
