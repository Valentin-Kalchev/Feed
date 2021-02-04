//
//  XCTestCase+FeedImageDataLoader.swift
//  EssentialAppTests
//
//  Created by Valentin Kalchev (Zuant) on 04/02/21.
//

import XCTest
import Feed

protocol FeedImageDataLoaderTestCase: XCTestCase {}

extension FeedImageDataLoaderTestCase {
    func expect(sut: FeedImageDataLoader, toCompleteWith expectedResult: FeedImageDataLoader.Result, when action: (() -> Void), file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load image data")
        _ = sut.loadImageData(from: anyURL()) { (receivedResult) in
            switch (expectedResult, receivedResult) {
            case (let .success(expectedData), let .success(receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
                
            case (let .failure(expectedError), let .failure(receivedError)):
                XCTAssertEqual(expectedError as NSError?, receivedError as NSError?, file: file, line: line)
                
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        action()
        
        wait(for: [exp], timeout: 1)
    }
}
