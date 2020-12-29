//
//  FeedErrorViewModel.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 29/12/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation
 
public struct FeedErrorViewModel {
    public let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
