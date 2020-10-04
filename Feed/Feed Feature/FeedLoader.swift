//
//  FeedLoader.swift
//  Feed
//
//  Created by Valentin Kalchev on 05/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

public typealias LoadFeedResult = Result <[FeedImage], Error> 

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
