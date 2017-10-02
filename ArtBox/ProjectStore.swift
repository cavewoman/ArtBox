//
//  ProjectStore.swift
//  ArtBox
//
//  Created by Anna Chan on 10/2/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class ProjectStore {
  var allProjects = [Project]()
  
  let projectArchiveURL: URL = {
    let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentDirectories.first!
    return documentDirectory.appendingPathComponent("project.archive")
  }()
  
  init() {
    if let archivedProjects = NSKeyedUnarchiver.unarchiveObject(withFile: projectArchiveURL.path) as? [Project] {
      allProjects = archivedProjects
    }
  }
  
  @discardableResult func createProject(name: String, date: Date, imageKey: String) -> Project {
    let project = Project(name: name, date: date, imageKey: imageKey)
    allProjects.append(project)
    return project
  }
  
  func findProject(byName name: String) -> Project? {
    let project = allProjects.filter { $0.name == name }
    if project.isEmpty {
      return nil
    } else {
      return project[0]
    }
  }
  
  func removeProject(_ project: Project) {
    if let index = allProjects.index(of: project) {
      allProjects.remove(at: index)
    }
  }
  
  func moveProject(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return
    }
    
    let project = allProjects[fromIndex]
    allProjects.remove(at: fromIndex)
    allProjects.insert(project, at: toIndex)
  }
  
  func saveChanges() -> Bool {
    return NSKeyedArchiver.archiveRootObject(allProjects, toFile: projectArchiveURL.path)
  }
  
  func getAllSortedProjects() -> [Project] {
    return allProjects.sorted { $0.name! < $1.name! }
  }
}
