//
//  ProjectDetailViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 10/2/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit


class ProjectDetailViewController: UIViewController, UITextFieldDelegate {
  var project: Project! {
    didSet {
      navigationItem.title = project.name
    }
  }
  
  var projectStore: ProjectStore!
  
}
