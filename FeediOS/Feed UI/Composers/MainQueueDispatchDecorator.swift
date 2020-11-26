//
//  MainQueueDispatchDecorator.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 26/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation
import Feed

// Decorator Pattern: Used to add behaviour to an instance while keeping the same interface
final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { completion() }
        }
        completion()
    }
}
extension MainQueueDispatchDecorator: FeedLoader where T == FeedLoader {
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] (result) in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchDecorator: FeedImageDataLoader where T == FeedImageDataLoader {
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] (result) in
            self?.dispatch { completion(result) }
        }
    }
}
