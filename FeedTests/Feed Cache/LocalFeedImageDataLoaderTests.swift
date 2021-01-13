//
//  LocalFeedImageDataLoaderTests.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 13/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import XCTest
import Feed

protocol FeedImageDataStore {
    func retrieve(dataFromURL url: URL)
}

final class LocalFeedImageDataLoader: FeedImageDataLoader {
    private struct Task: FeedImageDataLoaderTask {
        func cancel() {}
    }
    
    private let store: FeedImageDataStore
    init(store: FeedImageDataStore) {
        self.store = store
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        store.retrieve(dataFromURL: url)
        return Task()
    }
}

class LocalFeedImageDataLoaderTests: XCTestCase {
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        XCTAssertTrue(store.receivedMessages.isEmpty)
    }
    
    func test_loadImageDataFromURL_requestsStoreDataFromURL() {
        let (sut, store) = makeSUT()
        let url = anyURL()
        
        _ = sut.loadImageData(from: url) { _ in }
        XCTAssertEqual(store.receivedMessages, [.retrieve(dataFor: url)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentData: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedImageDataLoader, store: StoreSpy) {
        let store = StoreSpy()
        let sut = LocalFeedImageDataLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private class StoreSpy: FeedImageDataStore {
        enum Message: Equatable {
            case retrieve(dataFor: URL)
        }
        
        private(set) var receivedMessages = [Message]()
        func retrieve(dataFromURL url: URL) {
            receivedMessages.append(.retrieve(dataFor: url))
        }
    }
}
