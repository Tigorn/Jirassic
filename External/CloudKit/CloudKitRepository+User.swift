//
//  CloudKitRepository+User.swift
//  Jirassic
//
//  Created by Cristian Baluta on 02/04/2017.
//  Copyright © 2017 Imagin soft. All rights reserved.
//

import Foundation
import CloudKit

extension CloudKitRepository: RepositoryUser {
    
    func currentUser() -> User {
        
        if let user = self.user {
            return user
        }
        
        CKContainer.default().accountStatus(completionHandler: { (accountStatus, error) in
            if accountStatus == .noAccount {
//                self?.appWireframe.presentLoginController()
            } else {
//                self?.appWireframe.presentTasksController()
            }
        })
        //        if let puser = PUser.currentUser() {
        //            self.user = User(isLoggedIn: true, email: puser.email, userId: puser.objectId, lastSyncDate: nil)
        //        } else {
        self.user = User(isLoggedIn: false, email: nil, userId: nil, lastSyncDate: nil)
        //        }
        
        return self.user!
    }
    
    func loginWithCredentials (_ credentials: UserCredentials, completion: (NSError?) -> Void) {
        
    }
    
    func registerWithCredentials (_ credentials: UserCredentials, completion: (NSError?) -> Void) {
        
    }
    
    func logout() {
        user = nil
    }
}
