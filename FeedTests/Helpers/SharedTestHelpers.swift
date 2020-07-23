//
//  SharedTestHelpers.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 23/07/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}
