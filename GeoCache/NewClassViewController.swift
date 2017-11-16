//
//  NewCacheViewController.swift
//  GeoCache
//
// Created by Tina Wang on 10/22/17.
//

import UIKit

class NewCacheViewController: UIViewController {
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
    // of caches to the UserDefaults.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        cache = nil
        var geo_dict = [String: Any]()
        if let value : String = titleField.text {
            geo_dict["title"] =  value
        }
        else {
            cacheField.text = "Error: No title given."
        }
        
        if let value : String = detailField.text {
            geo_dict["details"] =  value
        }
        else {
            cacheField.text = "Error: No details given."
        }
        if let value : String = creatorField.text {
            geo_dict["creator"] =  value
        }
        else {
            cacheField.text = "Error: No creator given."
        }
        if let value : String = rewardField.text {
            geo_dict["reward"] =  value
        }
        else {
            cacheField.text = "Error: No reward given."
        }
        geo_dict["id"] = randomCacheId()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the saved GeoCaches from the UserDefaults when the app is started
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

