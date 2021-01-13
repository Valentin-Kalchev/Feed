//
//  CoreDataFeedStore+FeedImageDataLoader.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 13/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//
 
import CoreData

extension CoreDataFeedStore: FeedImageDataStore {
    public func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void) {
        perform { (context) in  
            completion(Result {
                let image = try? ManagedFeedImage.first(with: url, in: context)
                image?.data = data
                try? context.save()
            })
        }
    }
    
    public func retrieve(dataFromURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
        
        perform { (context) in
            completion(Result {
                return try ManagedFeedImage.first(with: url, in: context)?.data
            })
        }
    }
}
