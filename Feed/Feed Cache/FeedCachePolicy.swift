//
//  FeedCachePolicy.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 24/07/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

final class FeedCachePolicy { 
    private static let calendar = Calendar(identifier: .gregorian)
    private static let maxCacheAgeInDays = 7
    
    private init() {}
    
    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        
        return date < maxCacheAge
    }
}
