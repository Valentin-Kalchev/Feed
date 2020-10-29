//
//  FeedImageCellController.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 29/10/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import UIKit
import Feed

final class FeedImageCellController {
    private var task: FeedImageDataLoaderTask?
    private let model: FeedImage
    private let imageLoader: FeedImageDataLoader
    
    init(model: FeedImage, imageLoader: FeedImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func view() -> UITableViewCell {
        let cell = FeedImageCell()
        
        cell.locationContainer.isHidden = model.location == nil
        cell.locationLabel.text = model.location
        
        cell.descriptionLabel.text = model.description
        
        cell.feedImageView.image = nil
        cell.feedImageContainer.startShimmering()
        cell.feedRetryButton.isHidden = true
        
        let loadImage = { [weak self, weak cell] in
            guard let self = self else { return }
            
            self.task = self.imageLoader.loadImageData(from: self.model.url, completion: { [weak cell] result in
                let data = try? result.get()
                
                let image = data.map(UIImage.init) ?? nil
                cell?.feedImageView.image = image
                cell?.feedRetryButton.isHidden = (image != nil)
                cell?.feedImageContainer.stopShimmering()
            })
        }
        
        loadImage()
        cell.onRetry = loadImage
        
        return cell
    }
    
    func preload() {
        task = self.imageLoader.loadImageData(from: self.model.url, completion: { _ in })
    }
    
    deinit {
        task?.cancel()
    }
}
