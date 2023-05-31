//
//  Person.swift
//  RealmSwiftCRUD
//
//  Created by phmacr on 5/31/23.
//

import Foundation
import RealmSwift

class Person: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    var pets = List<Pet>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
