//
//  TableViewController.swift
//  GeoCache
//
//  Created by Tina Wang on 11/5/17.
//  Copyright © 2017 Tina Wang. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    // Create a GeoCache array
    var geocache_arr =  [GeoCache]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create closure to store all the GeoCache array information
        let closure: ([GeoCache]) -> () = { (caches) in
            self.geocache_arr = caches
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        // Load the array of GeoCaches from the closure
        loadCachesFromServer(onComplete: closure)
        
        for i in self.geocache_arr {
            // Assign images to caches
            let img_closure: (UIImage) -> () = { (image) in
                for j in 0...self.geocache_arr.count {
                    if self.geocache_arr[j].id == i.id {
                        self.geocache_arr[j].image = image
                    }
                }
            }
            pullImageFromServer(id: i.id, number: 0, onComplete: img_closure)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // We are only using one section here.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of caches in the geocache.
        return geocache_arr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        cell.textLabel?.text = (geocache_arr[indexPath.row].dictionary["title"] as! String)
        return cell
        
    }
    // Load new information to the table
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {
        // make sure the source property of the sender can be cast to a NewCacheNewCacheViewController
        // make sure cache property of the source is not nil
        let source = sender.source
        if let sender_temp : NewCacheViewController = (source as? NewCacheViewController) {
            if let cache_temp : GeoCache = sender_temp.cache {
                // add new cache to list of caches
                let indexPath = [IndexPath(row: geocache_arr.count, section: 0)]
                geocache_arr.append(cache_temp)
                tableView.insertRows(at: indexPath, with: .fade)
                // Send the GeoCache to the server
                sendCacheToServer(cache_temp)
            }
            else {
                return
                
            }
        }
        else {
            return
        }
    }
    
    // Make sure segue is performed to the Detail View
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: indexPath)
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if (segue.identifier == "ToDetail") {
            let row = (sender as? IndexPath)?.row
            if let detail_holder : DetailViewController = (segue.destination as? DetailViewController) {
                // Set description to the description of geocache_arr[row]
                if let row_holder : Int = row {
                    detail_holder.descrip = geocache_arr[row_holder].description
                    detail_holder.cache = geocache_arr[row_holder]
                    
                }
            }
        }
    }

}
