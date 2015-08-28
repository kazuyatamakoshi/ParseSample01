//
//  TopViewController.swift
//  ParseSample01
//
//  Created by k on 2015/08/27.
//  Copyright (c) 2015年 FranLiber Inc. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TopViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make sure cached users don't have to log in every time they open the app
        var currentUser = PFUser.currentUser()
        println(currentUser)
        if currentUser != nil {
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("alreadySignedIn", sender: self)
            }
        }
    }

    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
}