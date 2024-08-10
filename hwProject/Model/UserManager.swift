//
//  Manager.swift
//  hwProject
//
//  Created by 한철희 on 8/11/24.
//

import Foundation
import RealmSwift

class UserManager {
    let realm = try! Realm()
    
    func addUser(email: String, password: String) {
        let user = User()
        user.email = email
        user.password = password
        
        try! realm.write {
            realm.add(user)
        }
    }
    
    func getUser(byEmail email: String) -> User? {
        return realm.objects(User.self).filter("email == %@", email).first
    }
    
    func isEmailRegistered(_ email: String) -> Bool {
        return realm.objects(User.self).filter("email == %@", email).count > 0
    }
    
    func verifyUser(email: String, password: String) -> Bool {
        return realm.objects(User.self).filter("email == %@ AND password == %@", email, password).count > 0
    }
    
    func getAllUsers() -> Results<User> {
        return realm.objects(User.self)
    }
    
    func deleteUser(user: User) {
        try! realm.write {
            realm.delete(user)
        }
    }
    
    func printAllUsers() {
        let users = getAllUsers()
        users.forEach { user in
            print("User ID: \(user.id), Email: \(user.email), Password: \(user.password)")
        }
    }
}
