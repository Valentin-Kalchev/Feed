//
//  FeedImagePresenterTests.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 04/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import XCTest

class FeedImagePresenter {
    
    init(view: Any) {
        
    }
}

class FeedImagePresenterTests: XCTestCase {
    func test_init_doesNotSendMessagesToView() {
        let view = ViewSpy()
        _ = FeedImagePresenter(view: view)
        XCTAssertTrue(view.messages.isEmpty, "Expect no view messages")
    }

    private class ViewSpy {
        private(set) var messages: [Any] = []
    }
}
