//
//  FeedPresenter.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 07/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//
 
import Feed

protocol FeedLoadingView {
    func display(isLoading: Bool)
}

protocol FeedView {
    func display(feed: [FeedImage])
}

final class FeedPresenter {
    typealias Observer<T> = (T) -> Void
    
    private let feedLoader: FeedLoader
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var feedView: FeedView?
    var loadingView: FeedLoadingView?
    
    func loadFeed() {
        loadingView?.display(isLoading: true)
        
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.feedView?.display(feed: feed)
            }
            
            self?.loadingView?.display(isLoading: false)
        }
    }
}
