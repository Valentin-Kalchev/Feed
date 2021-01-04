//
//  FeedImageViewModel.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 04/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import Foundation
 
public struct FeedImageViewModel<Image> {
    
    public let description: String?
    public let location: String?
    public let image: Image?
    public let isLoading: Bool
    public let shouldRetry: Bool
    
    public var hasLocation: Bool {
        return location != nil
    }
    
    public init(description: String?, location: String?, image: Image?, isLoading: Bool, shouldRetry: Bool) {
        self.description = description
        self.location = location
        self.image = image
        self.isLoading = isLoading
        self.shouldRetry = shouldRetry
    }
}
