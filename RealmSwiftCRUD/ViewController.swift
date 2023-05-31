//
//  ViewController.swift
//  RealmSwiftCRUD
//
//  Created by phmacr on 5/31/23.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var realm: RealmManagerSource = RealmManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create a Person object with relation with 2 pets
        let person = Person()
        person.id = "1"
        person.name = "Mark Davis"
        person.age = 18

        let pet1 = Pet()
        pet1.id = "1"
        pet1.name = "Moochie"
        pet1.type = PetType.dog.rawValue

        let pet2 = Pet()
        pet2.id = "2"
        pet2.name = "Muffy"
        pet2.type = PetType.cat.rawValue

        person.pets.append(objectsIn: [pet1, pet2])
        realm.create(person)
        
        // Access the pets of a person
        if let fetchPerson = realm.fetchForType(Person.self, withKey: "1", withRefresh: false) {
            // create third Pet object for the person
            let pet3 = Pet()
            pet3.id = "3"
            pet3.name = "Machie"
            pet3.type = PetType.dog.rawValue
            
            realm.write(object: fetchPerson) { realmPerson in
                realmPerson.pets.append(pet3)
            }
            
            for pet in fetchPerson.pets {
                print("pet name: \(pet.name)") // Output: Moochie, Muffy, Machie
            }
        }
        
        // Access the owners of a pet
        if let fetchPet = realm.fetchForType(Pet.self, withKey: "2", withRefresh: false) {
            for owner in fetchPet.owners {
                print("owner name: \(owner.name) age: \(owner.age)") // Output: Mark Davis, 18
            }
        }
        
        // `Update` the retrieved Person object and `Delete` object
        if let fetchPerson2 = realm.fetchForType(Person.self, withKey: "1", withRefresh: false) {
            realm.updateObject(fetchPerson2) {
                fetchPerson2.name = "Mark Davis Crisostomo"
                fetchPerson2.age = 23
            }
            
            print("person name: \(fetchPerson2.name) age: \(fetchPerson2.age)")  // Output: Mark Davis Crisostomo, 23
            
            realm.delete(fetchPerson2)
        }
    }
}

