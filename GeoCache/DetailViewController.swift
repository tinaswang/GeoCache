//
//  DetailViewController.swift
//  GeoCache
//
//  Created by Tina Wang on 11/9/17.
//  Copyright © 2017 Tina Wang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // There's a weird error message if I name this
    // description.
    var descrip : String? = String()
    var cache : GeoCache? = nil
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let temp_string : String = descrip {
            descriptionText.text = temp_string
        }
        if let cache_img : UIImage = cache?.image {
            detailImage.image = cache_img
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    


    // MARK: - Navigation




}
