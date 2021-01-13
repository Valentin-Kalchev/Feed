//
//  FeedImageDataStore.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 13/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    func retrieve(dataFromURL url: URL, completion: @escaping (Result) -> Void)
}
