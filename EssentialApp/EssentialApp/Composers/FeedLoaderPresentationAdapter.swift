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
import Combine

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    private let feedLoader: () -> FeedLoader.Publisher
    private var cancellable: Cancellable?
    
    var presenter: FeedPresenter?
    
    init(feedLoader: @escaping () -> FeedLoader.Publisher) {
        self.feedLoader = feedLoader
    }
    
    func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()
        cancellable = feedLoader().sink { [weak self] (completion) in
            switch completion {
            case .finished: break
            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            }
            
        } receiveValue: { [weak self] (feed) in
            self?.presenter?.didFinishLoadingFeed(with: feed)
        }
        
//        feedLoader.load { [weak self] (result) in
//            switch result {
//            case let .success(feed):
//                self?.presenter?.didFinishLoadingFeed(with: feed)
//
//            case let .failure(error):
//                self?.presenter?.didFinishLoadingFeed(with: error)
//            }
//        }
    }
}
