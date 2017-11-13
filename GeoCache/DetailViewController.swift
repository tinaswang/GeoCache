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
    
    @IBOutlet weak var descriptionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let temp_string : String = descrip {
            descriptionText.text = temp_string
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    


    // MARK: - Navigation




}
