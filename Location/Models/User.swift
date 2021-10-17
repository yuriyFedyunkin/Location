//
//  User.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import RealmSwift

final class User: Object {
    @objc dynamic var login: String
    @objc dynamic var password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    override class func primaryKey() -> String? {
        return "login"
    }
}
