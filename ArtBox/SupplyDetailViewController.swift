//
//  SupplyDetailViewController.swift
//  ArtBox
//
//  Created by Anna Chan on 9/25/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import Foundation
import UIKit

class SupplyDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @IBOutlet var nameField: UITextField!
  @IBOutlet var amountField: UITextField!
  @IBOutlet var categoryField: UITextField!
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var removeImageButton: UIButton!
  
  @IBOutlet var cameraButton: UIBarButtonItem!
  @IBOutlet var uploadPhotoButton: UIBarButtonItem!
  
  @IBAction func saveSupply(_ sender: UIBarButtonItem) {
    if let enteredName = nameField.text, enteredName != "" {
      supply.name = nameField.text
    }
    
    if let enteredAmount = amountField.text, enteredAmount != "" {
      supply.amount = Double(enteredAmount) ?? 0.0
    }
    
    updateAndSaveCategoryName()
  }
  
  @IBAction func takePicture(_ sender: UIBarButtonItem) {
    let imagePicker = UIImagePickerController()
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      imagePicker.sourceType = .camera
    } else {
      imagePicker.sourceType = .photoLibrary
    }
    
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func uploadPicture(_ sender: UIBarButtonItem) {
    let imagePicker = UIImagePickerController()
    
    imagePicker.sourceType = .photoLibrary
   
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func removePicture(_ sender: UIButton) {
    let key = supply.supplyKey
    supplyImageStore.deleteImage(forKey: key!)
    imageView.image = nil
    removeImageButton.isHidden = true
  }
  
  var supply: Supply! {
    didSet {
      navigationItem.title = supply.name
    }
  }
  
  var supplyStore: SupplyStore!
  var supplyImageStore: SupplyImageStore!
  var categoryStore: CategoryStore!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let supplyName = supply.name {
      nameField.text = supplyName
    }
    
    if let supplyAmount = supply.amount {
      amountField.text = "\(supplyAmount)"
    }
    
    if let categoryName = supply.categoryName {
      categoryField.text = categoryName
    }
    
    let key = supply.supplyKey
    let imageToDisplay = supplyImageStore.image(forKey: key!)
    if (imageToDisplay != nil) {
      removeImageButton.isHidden = false
    } else {
      removeImageButton.isHidden = true
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      cameraButton.isEnabled = true
    } else {
      cameraButton.isEnabled = false
    }
    imageView.image = imageToDisplay
   }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if let enteredName = nameField.text, enteredName != "" {
      supply.name = nameField.text
      supply.amount = Double(amountField.text!) ?? 0.0
    } else {
      supplyStore.removeSupply(supply)
    }
    
    updateAndSaveCategoryName()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
    let image = info[UIImagePickerControllerEditedImage] as! UIImage
    supplyImageStore.setImage(image, forKey: supply.supplyKey!)
    imageView.image = image
    
    dismiss(animated: true, completion: nil)
  }
  
  func updateAndSaveCategoryName() {
    // If category field has text
    if let enteredCategoryName = categoryField.text {
      // If the supply currently has a category name
      if let currentCategoryName = supply.categoryName {
        // If the current category name does not equal"" and does not equal what as entered
        if currentCategoryName != enteredCategoryName && currentCategoryName != "" {
          // Find the current category
          let currentCategory = categoryStore.findCategory(byName: currentCategoryName)
          
          // if the current category is found
          if let foundCategory = currentCategory {
            // if the current category has a number of supplies
            if let categoryAmount = foundCategory.numOfSupplies {
              // Decrement the number of supplies
              foundCategory.numOfSupplies = categoryAmount - 1
              //remove the supply
              foundCategory.removeSupply(supply: supply)
            }
          }
        }
        //Try and find the entered category
        let enteredCategoryFound = categoryStore.findCategory(byName: enteredCategoryName)
        // If category found add supply to Category and increment numofsupplies
        if let enteredCategory = enteredCategoryFound {
          enteredCategory.supplies.append(supply)
          enteredCategory.numOfSupplies = enteredCategory.numOfSupplies! + 1
        } else {
          //If category not found add category with supply
          categoryStore.createCategory(name: enteredCategoryName, numOfSupplies: 1, supplies: [supply])
        }
      }
      supply.categoryName = enteredCategoryName
    }
  }
  
}
