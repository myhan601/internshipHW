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
    
    // 사용자를 추가합니다
    func addUser(email: String, password: String) {
        let user = User()
        user.email = email
        user.password = password
        
        try! realm.write {
            realm.add(user)
        }
    }
    
    // 이메일로 사용자를 가져옵니다
    func getUser(byEmail email: String) -> User? {
        return realm.objects(User.self).filter("email == %@", email).first
    }
    
    // 이메일이 등록되어 있는지 확인합니다
    func isEmailRegistered(_ email: String) -> Bool {
        return realm.objects(User.self).filter("email == %@", email).count > 0
    }
    
    // 이메일과 비밀번호로 사용자를 검증합니다
    func verifyUser(email: String, password: String) -> Bool {
        if let user = realm.objects(User.self).filter("email == %@ AND password == %@", email, password).first {
            loggedInUser = user
            return true
        }
        return false
    }
    
    // 모든 사용자를 가져옵니다
    func getAllUsers() -> Results<User> {
        return realm.objects(User.self)
    }
    
    // 사용자를 삭제합니다
    func deleteUser(user: User) {
        try! realm.write {
            realm.delete(user)
        }
    }
    
    // 모든 사용자 정보를 출력합니다
    func printAllUsers() {
        let users = getAllUsers()
        users.forEach { user in
            print("User Email: \(user.email), Password: \(user.password)")
        }
    }
    
    // 로그인된 사용자를 가져옵니다
    func getLoggedInUser() -> User? {
        return loggedInUser
    }
    
    // 로그인된 사용자를 설정합니다
    func setLoggedInUser(email: String) {
        loggedInUser = getUser(byEmail: email)
    }
    
    // 로그아웃합니다
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
