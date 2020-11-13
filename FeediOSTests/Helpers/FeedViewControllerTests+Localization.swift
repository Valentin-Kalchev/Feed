//
//  FeedViewController+Localization.swift
//  FeediOSTests
//
//  Created by Valentin Kalchev (Zuant) on 13/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation
import XCTest
import FeediOS

extension FeedViewControllerTests {
    func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedViewController.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        
        return value
    }
}
