//
//  WeakRefVirtualProxy.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 23/02/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import UIKit
import Feed
import FeediOS

final class WeakRefVirtualProxy<T: AnyObject> {
    private(set) weak var object:T?
    
    init(_ object: T) {
        self.object = object
    }
}
 
extension WeakRefVirtualProxy: FeedLoadingView where T: FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: FeedImageView where T: FeedImageView, T.Image == UIImage {
    func display(_ model: FeedImageViewModel<UIImage>) {
        object?.display(model)
    }
}

extension WeakRefVirtualProxy: FeedErrorView where T: FeedErrorView {
    func display(_ model: FeedErrorViewModel) {
        object?.display(model)
    }
}
