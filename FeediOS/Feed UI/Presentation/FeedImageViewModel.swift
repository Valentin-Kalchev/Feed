//
//  FeedImageViewModel.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 08/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
