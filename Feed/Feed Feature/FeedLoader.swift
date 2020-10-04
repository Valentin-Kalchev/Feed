//
//  FeedLoader.swift
//  Feed
//
//  Created by Valentin Kalchev on 05/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result <[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
