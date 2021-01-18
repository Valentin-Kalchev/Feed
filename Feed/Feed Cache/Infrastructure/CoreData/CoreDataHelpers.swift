//
//  CoreDataHelpers.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 30/09/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import CoreData

internal extension NSPersistentContainer {
    static func load(name: String, model: NSManagedObjectModel, url: URL) throws ->  NSPersistentContainer {
        let description = NSPersistentStoreDescription(url: url)
        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        container.persistentStoreDescriptions = [description]
        
        var loadError: Swift.Error?
        container.loadPersistentStores { loadError = $1 }
        try loadError.map { throw $0 }
        
        return container
    }
}
 
extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        guard let url = bundle.url(forResource: name, withExtension: "momd") else {
            return nil
        }
        
        return NSManagedObjectModel(contentsOf: url)
    }
}
