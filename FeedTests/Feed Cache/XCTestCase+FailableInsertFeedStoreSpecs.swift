//
//  XCTestCase+ FailableInsertFeedStoreSpecs.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 16/09/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import XCTest
import Feed

extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
    func assertThatInsertDeliversErrorOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)

        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line) 
    }

    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        insert((uniqueImageFeed().local, Date()), to: sut)

        expect(sut, toRetrieve: .empty, file: file, line: line)
    }
}
