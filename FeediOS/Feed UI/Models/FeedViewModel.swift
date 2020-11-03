//
//  FeedViewModel.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 03/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation
import Feed

final class FeedViewModel {
    private let feedLoader: FeedLoader
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var onChange: ((FeedViewModel) -> Void)?
    var onFeedLoad: (([FeedImage]) -> Void)?
    
    private(set) var isLoading: Bool = false {
        didSet {
            onChange?(self)
        }
    }
    
    func loadFeed() {
        isLoading = true
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            
            self?.isLoading = false
        }
    }
}
