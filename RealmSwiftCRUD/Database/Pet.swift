//
//  Pet.swift
//  RealmSwiftCRUD
//
//  Created by phmacr on 5/31/23.
//

import UIKit
import RealmSwift

enum PetType: Int {
    case dog
    case cat
    
    var type: String {
        switch self {
        case .cat:
            return "cat"
        case .dog:
            return "dog"
        }
    }
}

class Pet: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: Int = 0
    let owners: LinkingObjects<Person> = LinkingObjects(fromType: Person.self, property: "pets")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Pet {
    var petType: String {
        return PetType(rawValue: type)?.type ?? ""
    }
}
