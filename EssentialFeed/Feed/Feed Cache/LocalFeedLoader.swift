//
//  LocalFeedLoader.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 22/07/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

public final class LocalFeedLoader: FeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalFeedLoader {
    public typealias SaveResult = Result<Void, Error>
    
    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed { [weak self] deletionResult in
            guard let self = self else { return }
            switch deletionResult {
            case .success:
                self.cache(feed, with: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func cache(_ feed: [FeedImage], with completion: @escaping (SaveResult) -> Void) {
        self.store.insert(feed.toLocal(), timestamp: self.currentDate()) { [weak self] insertionResult in
            guard self != nil else { return }
            completion(insertionResult)
        }
    }
}

extension LocalFeedLoader {
    public typealias LoadResult = FeedLoader.Result
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                completion(.failure(error))
                
            case let .success(.some(cachedFeed)) where FeedCachePolicy.validate(cachedFeed.timestamp, against: self.currentDate()):
                completion(.success(cachedFeed.feed.toModels()))
            
            case .success:
                completion(.success([]))
            } 
        }
    }
}

extension LocalFeedLoader {
    
    public typealias ValidateResult = Result<Void, Error>
    
    public func validateCache(completion: @escaping (ValidateResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.store.deleteCachedFeed { _ in completion(.success(()))}
                
            case let .success(.some(cachedFeed)) where
                    !FeedCachePolicy.validate(cachedFeed.timestamp, against: self.currentDate()):
                self.store.deleteCachedFeed(completion: completion)
                
            case .success:
                completion(.success(()))
            }
        } 
    }
}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        return map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    }
}
