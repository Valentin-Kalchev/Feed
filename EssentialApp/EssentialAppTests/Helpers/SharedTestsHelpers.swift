//
//  SharedTestsHelpers.swift
//  EssentialAppTests
//
//  Created by Valentin Kalchev (Zuant) on 01/02/21.
//

import XCTest
import Feed

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
 
func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func uniqueFeed() -> [FeedImage] {
    return [FeedImage(id: UUID(), description: "any", location: "any", url: URL(string: "http://any-url.com")!)]
}

func anyData() -> Data {
    return Data("any data".utf8)
}
