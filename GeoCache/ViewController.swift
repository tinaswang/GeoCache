//
//  ViewController.swift
//  GeoCache
//
// Created by Tina Wang on 10/22/17.
//

import UIKit

class ViewController: UIViewController {
    // Create a GeoCache array
    var geocache_arr =  [GeoCache]()
    // Create a counter variable for cycling through GeoCaches
    var counter : Int = 0
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

    @IBAction func addGeoCache(_ sender: UIButton) {
        var geo_dict = [String: String]()
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

        geocache_arr.append(GeoCache(fromDictionary: geo_dict)!)
    }
    
    // Cycle the cache displayed in the cacheLabel, 
    // and setting the cacheLabel to the description property of that GeoCache
    @IBAction func nextCache(_ sender: UIButton) {
        cacheField.text = self.geocache_arr[counter].description
        if counter < self.geocache_arr.count {
            counter += 1
        }
        else {
            counter = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the saved GeoCaches from the UserDefaults when the app is started
        self.geocache_arr = loadCachesFromDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

