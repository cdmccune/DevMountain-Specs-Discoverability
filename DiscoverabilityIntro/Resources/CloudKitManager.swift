//
//  CloudKitManager.swift
//  DiscoverabilityIntro
//
//  Created by Curt McCune on 6/14/22.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    func requestDiscoverabilityAuthorization(completion: @escaping (CKContainer.ApplicationPermissionStatus, Error?) -> Void) {
        CKContainer.default().status(forApplicationPermission: .userDiscoverability) { status, error in
            guard status != .granted else {return completion(.granted, error)}
            
            CKContainer.default().requestApplicationPermission(.userDiscoverability, completionHandler: completion)
        }
    }
        
        func fetchUserIdentityWith(email: String, completion: @escaping (CKUserIdentity?, Error? ) -> Void) {
            
            CKContainer.default().discoverUserIdentity(withEmailAddress: email, completionHandler: completion)
            
        }
        
        func fetchAllDiscoverableUserIdentities(completion: @escaping ([CKUserIdentity], Error?) -> Void) {
            
            let discoverIdentities = CKDiscoverAllUserIdentitiesOperation()
            
            var discoveredIdentities: [CKUserIdentity] = []
            
            discoverIdentities.userIdentityDiscoveredBlock = { identity in
            
                discoveredIdentities.append(identity)
                
            }
            
            discoverIdentities.discoverAllUserIdentitiesResultBlock = {result in
                switch result {
                case .success():
                    completion(discoveredIdentities, nil)
                case .failure(let error):
                    completion(discoveredIdentities, error)
                }
            }
            
            CKContainer.default().add(discoverIdentities)
            
        }
    
    
    
    
}
