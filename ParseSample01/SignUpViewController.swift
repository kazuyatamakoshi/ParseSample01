//
//  SignUpViewController.swift
//  ParseSample01
//
//  Created by k on 2015/08/26.
//  Copyright (c) 2015年 FranLiber Inc. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class SignUpViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var message: UILabel!
    
    @IBAction func signUp(sender: UIButton) {
        self.processSignUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func processSignUp() {
       
        var userName = name.text
        var userEmailAddress = email.text
        var userPassword = password.text

        println(userName)
        println(userEmailAddress)
        println(userPassword)
        
        // Ensure username is lowercase
        userEmailAddress = userEmailAddress.lowercaseString
        
        // Create the user
        var user = PFUser()
        user.username = userName
        user.password = userPassword
        user.email = userEmailAddress
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                
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