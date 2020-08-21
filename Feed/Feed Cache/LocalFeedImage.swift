//
//  LocalFeedImage.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 22/07/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

// Data Transfer Object - DTO
public struct LocalFeedImage: Codable, Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}
