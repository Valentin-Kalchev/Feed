//
//  EssentialAppUIAcceptanceTests.swift
//  EssentialAppUIAcceptanceTests
//
//  Created by Valentin Kalchev (Zuant) on 19/02/21.
//

import XCTest
import Feed
import FeediOS

class EssentialAppUIAcceptanceTests: XCTestCase {

    func test_onLaunch_displayRemoteFeedWhenCustomerHasConnectivity() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.cells.count, 22)
//        XCTAssertEqual(app.cells.firstMatch.images.count, 1)
    }
}
