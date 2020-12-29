//
//  FeedErrorViewModel.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 16/12/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation 

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
