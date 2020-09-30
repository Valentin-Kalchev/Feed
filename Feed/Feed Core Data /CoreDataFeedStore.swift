//
//  CoreDataFeedStore.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 30/09/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataFeedStore: FeedStore {
    public init() {
        
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        fatalError()
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        fatalError()
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
}
