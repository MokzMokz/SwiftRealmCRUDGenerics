//
//  RealmManager.swift
//  RealmSwiftCRUD
//
//  Created by phmacr on 5/31/23.
//

import UIKit
import RealmSwift

protocol RealmManagerSource: AnyObject {
    // MARK: - Insert
    func create<T: Object>(_ object: T)
    func create<T: Object>(multiple objects: [T])
    
    // MARK: - Fetch
    func fetch<T: Object>(_ object: T.Type, withRefresh refresh: Bool) -> Results<T>
    func fetchForType<T, KeyType>(_ type: T.Type, withKey key: KeyType, withRefresh refresh: Bool) -> T? where T: Object
    
    // MARK: - Update
    func updateObject<T: Object>(_ object: T, with updates: () -> Void)
    func delete<T: Object>(_ object: T)
    
    func write<T: Object>(object: T, block: @escaping (T) -> Void)

    // MARK: - Error
    func logError(_ error: Error)
}

class RealmManager: RealmManagerSource {
    static let shared = RealmManager()
    
    // MARK: - INSERT
    func create<T: Object>(_ object: T) {
        let realm = try! Realm()
        do {
            try realm.safeWrite {
                realm.add(object, update: .all)
            }
        } catch {
            logError(error)
        }
    }
    
    func create<T: Object>(multiple objects: [T]) {
        let realm = try! Realm()
        
        do {
            try realm.safeWrite {
                realm.add(objects, update: .all)
            }
        } catch {
            logError(error)
        }
    }
    
    // MARK: - FETCH
    func fetch<T: Object>(_ object: T.Type, withRefresh refresh: Bool) -> Results<T> {
        let realm = try! Realm()
        if refresh {
            realm.refresh()
        }
        let result = realm.objects(object)
        return result
    }

    func fetchForType<T, KeyType>(_ type: T.Type, withKey key: KeyType, withRefresh refresh: Bool) -> T? where T: Object {
        let realm = try! Realm()
        if refresh {
            realm.refresh()
        }
        return realm.object(ofType: type, forPrimaryKey: key)
    }

    // MARK: - UPDATE
    func updateObject<T: Object>(_ object: T, with updates: () -> Void) {
        let realm = try! Realm()
        do {
            try realm.write {
                updates()
            }
        } catch {
            logError(error)
        }
    }

    
    // MARK: - DELETE
    func delete<T: Object>(_ object: T) {
        let realm = try! Realm()
        
        do {
            try realm.safeWrite {
                realm.delete(object)
            }
        } catch {
            logError(error)
        }
    }
    
    // MARK: - WRITE
    func write<T: Object>(object: T, block: @escaping (T) -> Void) {
        let realm = try! Realm()
        do {
            try realm.write {
                block(object)
            }
        } catch {
            logError(error)
        }
           
    }
    
    // MARK: - Error
    func logError(_ error: Error) {
        print("error: \(error)")
    }
}
