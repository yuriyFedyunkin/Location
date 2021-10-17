//
//  UsersDB.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import RealmSwift

protocol UsersDB {
    func write(_ user: User)
    func read(login: String) -> User?
}

final class UsersDBImpl: UsersDB {
    static var shared = UsersDBImpl()
    private var db = try? Realm()
    private init() {}
    
    func write(_ user: User) {
        do {
            print(db?.configuration.fileURL) // left for DB link tracing
            db?.beginWrite()
            db?.add(user, update: .modified)
            try db?.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func read(login: String) -> User? {
        if let user = db?.object(ofType: User.self, forPrimaryKey: login) {
            return user
        }
        return nil
    }
}
