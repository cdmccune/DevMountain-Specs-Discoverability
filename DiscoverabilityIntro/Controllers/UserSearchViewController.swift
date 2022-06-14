//
//  UserSearchViewController.swift
//  DiscoverabilityIntro
//
//  Created by Curt McCune on 6/14/22.
//

import UIKit

class UserSearchViewController: UIViewController {

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var userExistsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text else {return}
        
        var labelText = ""
        
        UserController.shared.checkForExistingUserWith(email: email) { user in
            if let user = user {
                //User exists as bot discoverable and in contacts
                
                labelText = "\(user.name) has the app and has authorized user discoverability (and is a part of your contacts list)"
            } else {
//                User either didn't accept discoverability and/or they aren't current
//                user's contact
                labelText = "User with email \(email) either didn't accept discoverability and/or they aren't current user's contact"
            }
            
            DispatchQueue.main.async {
                self.userExistsLabel.text = labelText
            }
            
            
        }
        
    }
    
   

}
