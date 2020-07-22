//
//  FeedStore.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 22/07/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ items: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
}
