//
//  FeedCacheIntegrationTests.swift
//  FeedCacheIntegrationTests
//
//  Created by Valentin Kalchev (Zuant) on 01/10/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import XCTest
import Feed

class FeedCacheIntegrationTests: XCTestCase {
    func test_loadFeed_deliversNoItemsOnEmptyCache() {
        let sut = makeFeedLoader()
        expect(sut: sut, toLoad: [])
    }
    
    func test_loadFeed_deliversItemsSavedOnASeparateInstance() {
        let sutToPerformSave = makeFeedLoader()
        let sutToPerformLoad = makeFeedLoader()
        let feed = uniqueImageFeed().models
        
        save(feed: feed, with: sutToPerformSave)
        expect(sut: sutToPerformLoad, toLoad: feed)
    }
    
    func test_saveFeed_overridesItemsSavedOnASeparateInstance() {
        let sutToPerformFirstSave = makeFeedLoader()
        let sutToPerformLastSave = makeFeedLoader()
        let sutToPerformLoad = makeFeedLoader()
        let firstFeed = uniqueImageFeed().models
        let latestFeed = uniqueImageFeed().models
        
        save(feed: firstFeed, with: sutToPerformFirstSave)
        save(feed: latestFeed, with: sutToPerformLastSave)
        
        expect(sut: sutToPerformLoad, toLoad: latestFeed)
    }
    
    func test_loadImageData_deliversSavedDataOnASeparateInstance() {
        let imageLoaderToPerformSave = makeImageLoader()
        let imageLoaderToPerformLoad = makeImageLoader()
        let feedLoader = makeFeedLoader()
        let image = uniqueImage()
        let dataToSave = anyData()
        
        save(feed: [image], with: feedLoader)
        save(dataToSave, for: image.url, with: imageLoaderToPerformSave)
        
        expect(imageLoaderToPerformLoad, toLoad: dataToSave, for: image.url)
    }
    
    func test_saveImageData_overridesSavedImageDataOnASeparateInstance() {
        let imageLoaderToPerformFirstSave = makeImageLoader()
        let imageLoaderToPerformLastSave = makeImageLoader()
        
        let imageLoaderToPerformLoad = makeImageLoader()
        let feedLoader = makeFeedLoader()
        let image = uniqueImage()
        let firstImageData = Data("first".utf8)
        let lastImageData = Data("last".utf8)
        
        save(feed: [image], with: feedLoader)
        save(firstImageData, for: image.url, with: imageLoaderToPerformFirstSave)
        save(lastImageData, for: image.url, with: imageLoaderToPerformLastSave)
        
        expect(imageLoaderToPerformLoad, toLoad: lastImageData, for: image.url)
    }
    
    func test_validateFeedCache_doesNotDeleteRecentlySavedFeed() {
        let feedLoaderToPerformSave = makeFeedLoader()
        let feedLoaderToPerformValidation = makeFeedLoader()
        let feed = uniqueImageFeed().models
        
        save(feed: feed, with: feedLoaderToPerformSave)
        validateCache(with: feedLoaderToPerformValidation)
        expect(sut: feedLoaderToPerformSave, toLoad: feed)
    }
    
    func test_validateFeedCache_deletesFeedSavedInADistantPast() {
        let feedLoaderToPerformSave = makeFeedLoader(currentDate: .distantPast)
        let feedLoaderToPerformValidation = makeFeedLoader(currentDate: Date())
        let feed = uniqueImageFeed().models
        
        save(feed: feed, with: feedLoaderToPerformSave)
        validateCache(with: feedLoaderToPerformValidation)
        
        expect(sut: feedLoaderToPerformSave, toLoad: [])
    }
    
    private func validateCache(with loader: LocalFeedLoader, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for save completion")
        loader.validateCache() { result in
            if case let Result.failure(error) = result {
                XCTFail("Expected t ovalidate feed successfully, got error \(error) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func expect(_ loader: LocalFeedImageDataLoader, toLoad expectedData: Data, for url: URL, file: StaticString = #file, line: UInt = #line) {
        
        let exp = expectation(description: "Wait to load data")
        _ = loader.loadImageData(from: url) { (result) in
            
            switch result {
            case let .success(receivedData):
                XCTAssertEqual(receivedData, expectedData, file: file, line: line)
                
            case let .failure(error):
                XCTFail("Expeted successful image data result, got \(error) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func save(_ data: Data, for url: URL, with loader: LocalFeedImageDataLoader, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for save completion")
        loader.save(data, for: url) { (result) in
            if case let Result.failure(error) = result {
                XCTFail("Expected to save image data successfully, got error: \(error)", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makeImageLoader(file: StaticString = #file, line: UInt = #line) -> LocalFeedImageDataLoader {
        let storeURL = testSpecificStoreURL()
        let store = try! CoreDataFeedStore(storeURL: storeURL)
        let sut = LocalFeedImageDataLoader(store: store)
        trackForMemoryLeaks(store)
        trackForMemoryLeaks(sut)
        return sut
    }
    
    private func makeFeedLoader(currentDate: Date = Date(), file: StaticString = #file, line: UInt = #line) -> LocalFeedLoader {
        let storeURL = testSpecificStoreURL()
        let store = try! CoreDataFeedStore(storeURL: storeURL)
        
        let sut = LocalFeedLoader(store: store, currentDate: { currentDate })
        trackForMemoryLeaks(store)
        trackForMemoryLeaks(sut)
        return sut
    }
    
    override func setUp() {
        super.setUp()
        setupEmptyStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        undoStoreSideEffects()
    }
    
    // MARK: - Helpers
    
    private func testSpecificStoreURL() -> URL {
        return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
    }
    
    private func cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    private func setupEmptyStoreState() {
        deleteStoreArtefacts()
    }
    
    private func undoStoreSideEffects() {
        deleteStoreArtefacts()
    }
    
    private func deleteStoreArtefacts() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }
    
    private func expect(sut: LocalFeedLoader, toLoad feed: [FeedImage], file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        sut.load { (result) in
            switch result {
            case let .success(imageFeed):
                XCTAssertEqual(imageFeed, feed, "Expected empty feed", file: file, line: line)
            case let .failure(error):
                XCTFail("Expected successful feed result, got \(error) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func save(feed: [FeedImage], with sut: LocalFeedLoader, file: StaticString = #file, line: UInt = #line) {
        let saveExp = expectation(description: "Wait for save completion")
        sut.save(feed) { (result) in
            if case let Result.failure(error) = result {
                XCTAssertNil(error, "Expected to save feed successfully, got \(error) instead", file: file, line: line)
            }
            
            saveExp.fulfill()
        }
        wait(for: [saveExp], timeout: 1.0)
    }
}
