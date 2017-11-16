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
    var id: Int
    //  A failable initializer which takes a dictionary, with values for the
    //    keys “title”, “details”, “creator”, and “reward”.
    //    If any of these is missing, the initializer returns nil.
    init?(fromDictionary dict: [String: Any]) {
        // Check whether each value is present
        if let value : String = dict["title"] as? String {
            self.title = value
        }
        else {
            return nil
        }
        
        if let value: String = dict["details"] as? String {
            self.details = value
        }
        
        else {
            return nil
        }
        if let value : String = dict["creator"] as? String {
            self.creator = value
        }
        else {
            return nil
        }
        
        if let value: String = dict["reward"] as? String {
            self.reward = value
        }
            
        else {
            return nil
        }
        if let value: Int = (dict["id"] as? Int) {
            self.id = value
        }
            
        else {
            return nil
        }
    }
    
    //  dictionary: a computed property which returns a dictionary using the GeoCache information
    var dictionary: ([String: Any]) {
        get {
            var geo_dict = [String: Any]()
            geo_dict["title"] =  self.title
            geo_dict["details"] =  self.details
            geo_dict["creator"] =  self.creator
            geo_dict["reward"] =  self.reward
            geo_dict["id"] = self.id
            return geo_dict
            
        }

    }
    
    // Prints out the GeoCache information.
    
    var description: String {
        get {
            return ("\(title): \nLocated at \(details)" +
                    " with reward \(reward).\nCreated by \(creator).")
        }
    }
}
    // Get a random number
    func randomCacheId() -> Int {
        return Int(arc4random())
    }
    // Send a dictionary representing a GeoCache to the server by making a request to serverURL/createCache with a POST method and a body which is the JSON data.
    func sendCacheToServer(_ cache: GeoCache) {
        var request = URLRequest(url: URL(string: "http://localhost:5000/createCache")!)
        // set the httpMethod and httpBody fields of the URLRequest
        request.httpMethod = "POST"
        // Serialize dictionary representation of GeoCache in JSON
        let data = try? JSONSerialization.data(withJSONObject: cache.dictionary)
        request.httpBody = data
        // set the http header “Content-Type” to “application/json”
        request.setValue("Content-Type", forHTTPHeaderField: "application/json")
        // Make a request
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription )
                return
            }
        }
        task.resume()
    }
    
    
    
//    Make a GET request to the server at the endpoint /getCaches to get all the
// server's GeoCaches.

    func loadCachesFromServer(onComplete: @escaping ([GeoCache]) -> ()) {
        // Result array of GeoCaches
        var result = [GeoCache]()
        var request = URLRequest(url: URL(string: "http://localhost:5000/getCaches")!)
        // set the httpMethod and httpBody fields of the URLRequest
        request.httpMethod = "GET"
        // set the http header “Content-Type” to “application/json”
        request.setValue("Content-Type", forHTTPHeaderField: "application/json")
        // Make a request to get all the GeoCaches in the database
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription )
                return
            }
            else {
                do {
        
                    //  turn our JSON object to a Swift object and cast that to the Swift [[String: Any]]
                    let caches = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                    for geo_dict in caches {
                        result.append(GeoCache(fromDictionary: geo_dict)!)
                        //  call the onComplete closure with the result array as its only argument
                        onComplete(result)
                    }
                    
                }
                catch let error as NSError {
                    print(error)
                }
            }
        }
        task.resume()
    }



