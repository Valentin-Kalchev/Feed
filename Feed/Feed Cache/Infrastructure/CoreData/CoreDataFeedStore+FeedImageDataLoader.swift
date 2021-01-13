//
//  CoreDataFeedStore+FeedImageDataLoader.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 13/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import Foundation 

extension CoreDataFeedStore: FeedImageDataStore {
    public func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void) {
    }
    
    public func retrieve(dataFromURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
        completion(.success(.none))
    }
}
