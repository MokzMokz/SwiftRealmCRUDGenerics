//
//  Realm+Extensions.swift
//  RealmSwiftCRUD
//
//  Created by phmacr on 5/31/23.
//

import Foundation

import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
