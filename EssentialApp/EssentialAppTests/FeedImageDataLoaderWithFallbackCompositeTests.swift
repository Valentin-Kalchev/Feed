//
//  FeedImageDataLoaderWithFallbackCompositeTests.swift
//  EssentialAppTests
//
//  Created by Valentin Kalchev (Zuant) on 01/02/21.
//

import XCTest
import Feed
import EssentialApp
 
class ImageDataLoaderStub: FeedImageDataLoader {
    private let result: FeedImageDataLoader.Result
    init(result: FeedImageDataLoader.Result) {
        self.result = result
    }
    
    private class TaskWrapper: FeedImageDataLoaderTask {
        var wrapped: FeedImageDataLoaderTask?
        func cancel() {
             wrapped?.cancel()
        }
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        completion(result)
        return TaskWrapper()
    }
}

class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase, FeedImageDataLoaderTestCase {
    func test_loadImageData_deliversPrimaryImageDataOnPrimaryLoaderSuccess() {
        let primaryData = uniqueImageData()
        let sut = makeSUT(primaryResult: .success(primaryData), fallbackResult: .success(uniqueImageData()))
        expect(sut: sut, toCompleteWith: .success(primaryData)) {}
    }
    
    func test_loadImageData_deliversFallbackImageDataOnPrimaryFailure() {
        let fallbackData = uniqueImageData()
        let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .success(fallbackData))
        expect(sut: sut, toCompleteWith: .success(fallbackData)) {}
    }
    
    func test_loadImageData_deliversErrorOnPrimaryAndFallbackImageDataFailure() {
        let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .failure(anyNSError()))
        expect(sut: sut, toCompleteWith: .failure(anyNSError())) {}
    }
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: FeedImageDataLoader.Result, fallbackResult: FeedImageDataLoader.Result, file: StaticString = #file, line: UInt = #line) -> FeedImageDataLoader {
        let primary = ImageDataLoaderStub(result: primaryResult)
        let fallback = ImageDataLoaderStub(result: fallbackResult)
        let sut = FeedImageDataLoaderWithFallbackComposite(primary: primary, fallback: fallback)
        trackForMemoryLeak(primary, file: file, line: line)
        trackForMemoryLeak(fallback, file: file, line: line)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
    
    private func uniqueImageData() -> Data {
        return Data("any data".utf8)
    }
}
