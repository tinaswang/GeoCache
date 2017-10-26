//
//  GeoCache.swift
//  GeoCache is a struct to keep track of geocache
//  properties and other information.
//  Created by Tina Wang on 10/22/17.
//  
//

import Foundation

struct GeoCache {
    // Variables for all the textfields
    var title: String
    var details: String
    var creator: String
    var reward: String

    //  A failable initializer which takes a dictionary, with values for the
    //    keys “title”, “details”, “creator”, and “reward”.
    //    If any of these is missing, the initializer returns nil.
    init?(fromDictionary dict: [String: String]) {
        // Check whether each value is present
        if let value : String = dict["title"] {
            self.title = value
        }
        else {
            return nil
        }
        
        if let value: String = dict["details"] {
            self.details = value
        }
        
        else {
            return nil
        }
        if let value : String = dict["creator"] {
            self.creator = value
        }
        else {
            return nil
        }
        
        if let value: String = dict["reward"] {
            self.reward = value
        }
            
        else {
            return nil
        }
    }
    
    //  dictionary: a computed property which returns a dictionary using the GeoCache information
    var dictionary: [String: String] {
        get {
            var geo_dict = [String: String]()
            geo_dict["title"] =  self.title
            geo_dict["details"] =  self.details
            geo_dict["creator"] =  self.creator
            geo_dict["reward"] =  self.reward
            return geo_dict
            
        }

    }
    
    // Prints out the GeoCache information.
    
    var description: String {
        get {
            return "\(title): \n Located at \(details) " +
                    "with reward \(reward).\nCreated by \(creator)."
        }
    }
}

    //  Look up an array in UserDefaults and attempt to convert each element 
    // in the array into a dictionary of type [String: String].
    // Feed those into the initializer for GeoCache, 
    // and return an array of those results.

    func loadCachesFromDefaults() -> [GeoCache] {
        let defaults = UserDefaults.standard
        var result = [GeoCache]()
        // Feed in each GeoCache into the failable initializer
        if let cache_info = defaults.array(forKey: "cache_info") {
            for i in cache_info {
                let i_dict = i as! [String: String]
                result.append(GeoCache(fromDictionary: i_dict)!)
            }
        }
        else {
            result = []
        }
        
        return result
    }
    //  saveCachesToDefaults: takes an array of GeoCaches and saves it 
    // to the standard UserDefaults under the key name "cache_info."
    func saveCachesToDefaults(_ caches: [GeoCache]) {
        var cache_info = [[String: String]]()
        for i in caches {
            cache_info.append(i.dictionary)
        }
        let defaults = UserDefaults.standard
        defaults.set(cache_info, forKey: "cache_info")
        defaults.synchronize()
    }


