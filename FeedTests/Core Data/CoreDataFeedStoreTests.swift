//
//  CoreDataFeedStoreTests.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 30/09/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import XCTest
import Feed

class CoreDataFeedStoreTests: XCTestCase, FeedStoreSpecs {
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let sut = makeSUT()
        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        // TODO
    }
    
    func test_insert_deliversNoErrorOnEmptyCache() {
        // TODO
    }
    
    func test_insert_deliversNoErrorOnNonEmptyCache() {
        // TODO
    }
    
    func test_insert_overridesPreviouslyInsertedCacheValues() {
        // TODO
    }
    
    func test_delete_deliversNoErrorOnEmptyCache() {
        // TODO
    }
    
    func test_delete_hasNoSideEffectsOnEmptyCache() {
        // TODO
    }
    
    func test_delete_deliversNoErrorOnNonEmptyCache() {
        // TODO
    }
    
    func test_delete_emptiesPreviouslyInsertedCache() {
        // TODO
    }
    
    func test_storeSideEffects_runSerially() {
        // TODO
    }
    

    // MARK: - Helpers
    
    func makeSUT() -> CoreDataFeedStore {
        let storeURL = URL(fileURLWithPath: "/dev/null")
        let bundle = Bundle(for: CoreDataFeedStore.self)
        let sut = try! CoreDataFeedStore(storeURL: storeURL, bundle: bundle)
        trackForMemoryLeaks(sut)
        return sut
    }
}
