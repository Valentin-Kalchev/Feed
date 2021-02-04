//
//  XCTest+FeedLoader.swift
//  EssentialAppTests
//
//  Created by Valentin Kalchev (Zuant) on 04/02/21.
//

import XCTest
import Feed

protocol FeedLoaderTestCase: XCTestCase {}

extension FeedLoaderTestCase {
    func expect(sut: FeedLoader, toCompleteWith expectedResult: FeedLoader.Result, file: StaticString = #file, line: UInt = #line) {
        
        let exp = expectation(description: "Wait for load completion")
        sut.load { (receivedResult) in
            switch (expectedResult, receivedResult) {
            case (let .success(expectedFeed), let .success(receivedFeed)):
                XCTAssertEqual(expectedFeed, receivedFeed, file: file, line: line)
                
            case (.failure, .failure):
                break
                
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
}
