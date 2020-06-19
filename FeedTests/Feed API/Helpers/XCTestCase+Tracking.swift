//
//  XCTestCase+Tracking.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 19/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Poterntial memory leak", file: file, line: line)
        }
    }
}
