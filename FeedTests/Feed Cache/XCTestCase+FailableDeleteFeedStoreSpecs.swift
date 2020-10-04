//
//  XCTestCase+FailableDeleteFeedStoreSpecs.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 16/09/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import XCTest
import Feed

extension FailableDeleteFeedStoreSpecs where Self: XCTestCase {
    func assertThatDeleteDeliversErrorOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)
        XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        _ = deleteCache(from: sut)

        expect(sut, toRetrieve: .success(.empty), file: file, line: line)
    }
}
