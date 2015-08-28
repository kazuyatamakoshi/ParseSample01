//
//  SignInViewController.swift
//  ParseSample01
//
//  Created by k on 2015/08/26.
//  Copyright (c) 2015年 FranLiber Inc. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var message: UILabel!

    
    @IBAction func signIn(sender: UIButton) {
        
        var userEmailAddress = email.text
        userEmailAddress = userEmailAddress.lowercaseString
        
        var userPassword = password.text
        
        PFUser.logInWithUsernameInBackground(userEmailAddress, password:userPassword) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("signInToNavigation", sender: self)
                }
            } else {
                
                if let message: AnyObject = error!.userInfo!["error"] {
                    self.message.text = "\(message)"
                }
            }
        }

    }
}