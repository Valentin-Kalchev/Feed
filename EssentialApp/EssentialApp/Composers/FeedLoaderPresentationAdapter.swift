//
//  FeedLoaderPresentationAdapter.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 23/02/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import Foundation
import Feed
import FeediOS

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    private let feedLoader: FeedLoader
    var presenter: FeedPresenter?
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()
        
        feedLoader.load { [weak self] (result) in
            switch result {
            case let .success(feed):
                self?.presenter?.didFinishLoadingFeed(with: feed)
                
            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            }
        }
    }
}
