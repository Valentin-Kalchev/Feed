//
//  FeedPresenter.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 07/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//
 
import Foundation
import Feed

struct FeedLoadingViewModel {
    let isLoading: Bool
}

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

struct FeedViewModel {
    let feed: [FeedImage]
}

protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
    
    private let feedView: FeedView
    private let loadingView: FeedLoadingView
    
    init(feedView: FeedView, loadingView: FeedLoadingView) {
        self.feedView = feedView
        self.loadingView = loadingView
    }
    
    static var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE", tableName: "Feed", bundle: Bundle(for: FeedPresenter.self), comment: "Title for the feed view")
    }
    
    func didStartLoadingFeed() {
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { [weak self] in
                self?.didFinishLoadingFeed(with: feed)
            }
        }
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { [weak self] in
                self?.didFinishLoadingFeed(with: error)
            }
        }
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
