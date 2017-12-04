//
//  NewCacheViewController.swift
//  GeoCache
//
// Created by Tina Wang on 10/22/17.
//

import UIKit

class NewCacheViewController: UIViewController, UIImagePickerControllerDelegate,
                                                UINavigationControllerDelegate {
    

    @IBOutlet weak var imagePreview: UIImageView!
    // create a UIImagePickerController()
    let picker = UIImagePickerController()
    // Create a GeoCache array
    var cache : GeoCache? = nil
    // Create a counter variable for cycling through GeoCaches
    // var counter : Int = 0
    // IBOOutlet for the text fields

    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var detailField: UITextField!
    
    @IBOutlet weak var creatorField: UITextField!
    
    @IBOutlet weak var rewardField: UITextField!
    
    @IBOutlet weak var cacheField: UILabel!
    
    
    // Take whatever’s entered in the four text fields,
    // and use them to create a new GeoCache.
    // Print an error message if any of these fields are empty.
    // Add the new GeoCache to the list of caches, and save the list
    // of caches to the server.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        cache = nil
        var geo_dict = [String: Any]()
        if let value : String = titleField.text, !value.isEmpty  {
            geo_dict["title"] =  value
        }
        else {
            cacheField.text = "Error: No title given."
            return
        }
        
        if let value : String = detailField.text, !value.isEmpty  {
            geo_dict["details"] =  value
        }
        else {
            cacheField.text = "Error: No details given."
        }
        if let value : String = creatorField.text, !value.isEmpty  {
            geo_dict["creator"] =  value
        }
        else {
            cacheField.text = "Error: No creator given."
        }
        if let value : String = rewardField.text, !value.isEmpty  {
            geo_dict["reward"] =  value
        }
        else {
            cacheField.text = "Error: No reward given."
        }
        geo_dict["id"] = randomCacheId()
        geo_dict["image"] = imagePreview.image
        if let new_cache: GeoCache = GeoCache(fromDictionary: geo_dict) {
            cache = (new_cache)
        }
    }


    // cancel: Call when the user does not want to save the GeoCache
    // and presses the 'cancel' button.
   @IBAction func cancel(sender: UIBarButtonItem) {
        // set cache property to nil
        cache = nil
        // call dismiss method
        self.dismiss(animated: true, completion: nil)
    }
    
    // Called when an image is selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let img : UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePreview.image = img
            imagePreview?.contentMode = .scaleAspectFit
            picker.dismiss(animated: true, completion: nil)
        }
    
    }
    // dismiss the picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the saved GeoCaches from the server when the app is started
        picker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Allow for photo editing
    @IBAction func pickImage(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    
}

