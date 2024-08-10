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
    private let userDefaults = UserDefaults.standard
    
    var loggedInUser: User? {
        get {
            if let email = userDefaults.string(forKey: "LoggedInUserEmail") {
                return getUser(byEmail: email)
            }
            return nil
        }
        set {
            if let email = newValue?.email {
                userDefaults.set(email, forKey: "LoggedInUserEmail")
            } else {
                userDefaults.removeObject(forKey: "LoggedInUserEmail")
            }
        }
    }
    
    // 사용자를 추가
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
    
    // 등론된 이메일인지 확인
    func isEmailRegistered(_ email: String) -> Bool {
        return realm.objects(User.self).filter("email == %@", email).count > 0
    }
    
    func verifyUser(email: String, password: String) -> Bool {
        if let user = realm.objects(User.self).filter("email == %@ AND password == %@", email, password).first {
            loggedInUser = user
            return true
        }
        return false
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
            print("User Email: \(user.email), Password: \(user.password)")
        }
    }
    
    func getLoggedInUser() -> User? {
        return loggedInUser
    }
    
    func setLoggedInUser(email: String) {
        loggedInUser = getUser(byEmail: email)
    }
    
    func logoutUser() {
        loggedInUser = nil
    }
    
    func deleteLoggedInUser() -> Bool {
        guard let user = loggedInUser else { return false }
        
        do {
            try realm.write {
                realm.delete(user)
            }
            logoutUser()
            return true
        } catch {
            print("Error deleting user: \(error)")
            return false
        }
    }
}
