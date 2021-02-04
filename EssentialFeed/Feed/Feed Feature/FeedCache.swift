//
//  FeedCache.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 04/02/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
