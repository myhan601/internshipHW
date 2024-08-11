//
//  DataModel.swift
//  hwProject
//
//  Created by 한철희 on 8/11/24.
//

import RealmSwift
import Foundation

class User: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""

    
    // Realm의 primary key를 설정하려면 다음 메서드를 추가합니다.
    override static func primaryKey() -> String? {
        return "id"
    }
}
