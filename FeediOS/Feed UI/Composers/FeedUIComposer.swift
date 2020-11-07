//
//  FeedUIComposer.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 29/10/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import UIKit
import Feed

// Composition pattern
public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        
        let feedViewModel = FeedViewModel(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(viewModel: feedViewModel)
        
        let feedController = FeedViewController(refreshController: refreshController)
        
        feedViewModel.onFeedLoad = adaptFeedtoCellControllers(forwardingTo: feedController, loader: imageLoader)
        
        return feedController
    }
    
    private static func adaptFeedtoCellControllers(forwardingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak controller] feed in
            // Adapter Pattern - transforms feed images to feed image cell controllers
            controller?.tableModel = feed.map { model in
                let feedImageViewModel = FeedImageViewModel(imageLoader: loader, model: model, imageTransformer: UIImage.init)
                return FeedImageCellController(viewModel: feedImageViewModel)
            }
        }
    }
}
