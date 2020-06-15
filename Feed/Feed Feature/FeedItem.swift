//
//  FeedItem.swift
//  Feed
//
//  Created by Valentin Kalchev on 05/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
