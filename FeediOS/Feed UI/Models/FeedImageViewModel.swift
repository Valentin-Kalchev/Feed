//
//  FeedImageViewModel.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 03/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation
import Feed

final class FeedImageViewModel<Image> {
    typealias Observer<T> = (T) -> Void
    
    private let model: FeedImage
    private let imageLoader: FeedImageDataLoader
    private var task: FeedImageDataLoaderTask?
    private let imageTransformer: (Data) -> Image?
    
    var hasLocation: Bool {
        return model.location != nil
    }
    
    var location: String? {
        return model.location
    }
    
    var description: String? {
        return model.description
    }
    
    init(imageLoader: FeedImageDataLoader, model: FeedImage, imageTransformer: @escaping (Data) -> Image?) {
        self.imageLoader = imageLoader
        self.model = model
        self.imageTransformer = imageTransformer
    }
    
    var onImageLoad: Observer<Image>?
    var onImageLoadingStateChange: Observer<Bool>?
    var onShouldRetryImageLoadStateChange: Observer<Bool>?
    
    func loadImageData() {
        onImageLoadingStateChange?(true)
        onShouldRetryImageLoadStateChange?(false)
        
        self.task = self.imageLoader.loadImageData(from: model.url, completion: { [weak self](result) in
            self?.handle(result)
        })
    }
    
    private func handle(_ result: FeedImageDataLoader.Result) {
        if let image = (try? result.get()).flatMap(imageTransformer) {
            onImageLoad?(image)
        } else {
            onShouldRetryImageLoadStateChange?(true)
        }
        
        onImageLoadingStateChange?(false)
    }
    
    func cancelImageDataLoad() {
        self.task?.cancel()
        self.task = nil
    }
}
