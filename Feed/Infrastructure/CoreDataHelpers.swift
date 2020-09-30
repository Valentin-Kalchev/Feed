//
//  CoreDataHelpers.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 30/09/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import CoreData

internal extension NSPersistentContainer {
    enum LoadingError: Swift.Error {
        case modelNotFound
        case failedToLoadPersistentStores(Swift.Error)
    }
    
    static func load(with name: String, url: URL, in bundle: Bundle) throws ->  NSPersistentContainer {
        guard let managedObjectModel = NSManagedObjectModel.load(with: name, in: bundle) else {
            throw LoadingError.modelNotFound
        }
        
        let description = NSPersistentStoreDescription(url: url)
        let container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions = [description]
        
        var loadError: Swift.Error?
        container.loadPersistentStores { loadError = $1 }
        try loadError.map { throw LoadingError.failedToLoadPersistentStores($0)}
        
        return container
    }
}

private extension NSManagedObjectModel {
    static func load(with name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        guard let url = bundle.url(forResource: name, withExtension: "momd") else {
            return nil
        }
        
        return NSManagedObjectModel(contentsOf: url)
    }
}
