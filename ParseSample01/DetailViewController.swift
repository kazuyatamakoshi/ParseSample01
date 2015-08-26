//
//  DetailViewController.swift
//  ParseSample01
//
//  Created by k on 2015/08/24.
//  Copyright (c) 2015年 FranLiber Inc. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class DetailViewController: UIViewController{
    
    @IBOutlet weak var article_title: UITextField!
    @IBOutlet weak var body: UITextView!

    // Container to store the view table selected object
    var currentObject : PFObject?
    

    @IBAction func saveButton(sender: UIBarButtonItem) {
        if let updateObject = currentObject as PFObject? {
            
            // Update the existing parse object
            updateObject["title"] = article_title.text
            updateObject["body"] = body.text
            
            // Save the data back to the server in a background task
            updateObject.saveEventually()
        }else {
            
            // Create a new parse object
            var updateObject = PFObject(className:"Articles")
            
            updateObject["title"] = article_title.text
            updateObject["body"] = body.text
            
            // Save the data back to the server in a background task
            updateObject.saveEventually()
        }
        
        // Return to table view
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        // Unwrap the current object object
        if let object = currentObject {
            article_title.text = object["title"] as! String
            body.text = object["body"] as! String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}