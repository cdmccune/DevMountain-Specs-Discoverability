//
//  UserController.swift
//  DiscoverabilityIntro
//
//  Created by Curt McCune on 6/14/22.
//

import Foundation

class UserController {
    
    static var shared = UserController()
    
    var users: [User] = []
    
    let nameFormatter: PersonNameComponentsFormatter = {
        let formatter = PersonNameComponentsFormatter()
        formatter.style = .long
        return formatter
    }()
    
    func checkForExistingUserWith(email: String, completion: @escaping (User?) -> Void) {
        CloudKitManager.shared.fetchUserIdentityWith(email: email) { userIdentity, error in
            
            if let error = error {
                print("error on user email search: \(error.localizedDescription)")
            }
            
            guard let userIdentity = userIdentity,
            let nameComponents = userIdentity.nameComponents else {return completion(nil)}
            
            let name = self.nameFormatter.string(from: nameComponents)
            
            let user = User(name: name)
            
            return completion(user)
        }
    }
    
    func fetchAllDiscoverableUsers(completion: @escaping() -> Void) {
        
        CloudKitManager.shared.fetchAllDiscoverableUserIdentities { userIdentities, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let nameComponentsArray = userIdentities.compactMap({ $0.nameComponents})
            
            let formattedNames = nameComponentsArray.map({self.nameFormatter.string(from: $0)})
            
            let users = formattedNames.map({User(name: $0)})
            
            self.users = users
            
            completion()
        }
    }
}
