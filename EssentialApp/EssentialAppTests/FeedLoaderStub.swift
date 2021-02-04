//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by Valentin Kalchev (Zuant) on 04/02/21.
//

import Foundation
import Feed
 
class FeedLoaderStub: FeedLoader {
    private let result: FeedLoader.Result
    init(result: FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completion(result)
    }
}
