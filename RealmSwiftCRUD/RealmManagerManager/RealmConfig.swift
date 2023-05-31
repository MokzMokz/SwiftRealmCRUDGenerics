//
//  RealmConfig.swift
//  RealmSwiftCRUD
//
//  Created by phmacr on 5/31/23.
//

import Foundation
import RealmSwift

class RealmConfig {
    static let shared = RealmConfig()
    var currentSchemaVersion: UInt64 = 1
    
    func configureRealm() {
        // Define a custom Realm configuration
        let config = Realm.Configuration(
            //fileURL: URL(fileURLWithPath: "path/to/realm/file"), // --> optional for different path
            schemaVersion: currentSchemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Perform migration if needed
                }
            }
        )

        // Set the custom configuration as the default Realm configuration
        Realm.Configuration.defaultConfiguration = config
    }
}
