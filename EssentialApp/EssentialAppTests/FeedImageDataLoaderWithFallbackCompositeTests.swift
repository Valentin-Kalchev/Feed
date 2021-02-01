//
//  FeedImageDataLoaderWithFallbackCompositeTests.swift
//  EssentialAppTests
//
//  Created by Valentin Kalchev (Zuant) on 01/02/21.
//

import XCTest
import Feed
 
class ImageDataLoaderStub: FeedImageDataLoader {
    private let result: FeedImageDataLoader.Result
    init(result: FeedImageDataLoader.Result) {
        self.result = result
    }
    
    class RemoteFeedImageDataLoaderTask: FeedImageDataLoaderTask {
        func cancel() {
             
        }
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        completion(result)
        return RemoteFeedImageDataLoaderTask()
    }
}

class FeedImageDataLoaderWithFallbackComposite: FeedImageDataLoader {
    private let primary: FeedImageDataLoader
    private let fallback: FeedImageDataLoader
    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    class FeedImageDataLoaderWithFallbackDataLoaderTask: FeedImageDataLoaderTask {
        func cancel() {
             
        }
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        primary.loadImageData(from: url) { [weak self] (result) in
            switch result {
            case .success:
                completion(result)
            case .failure:
                self?.fallback.loadImageData(from: url, completion: completion)
            }
        }
        return FeedImageDataLoaderWithFallbackDataLoaderTask()
    }
}

class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase {
    func test_loadImageData_deliversPrimaryImageDataOnPrimaryLoaderSuccess() {
        let primaryData = uniqueImageData()
        let sut = makeSUT(primaryResult: .success(primaryData), fallbackResult: .success(uniqueImageData()))
        expect(sut: sut, toCompleteWith: .success(primaryData))
    }
    
    func test_loadImageData_deliversFallbackImageDataOnPrimaryFailure() {
        let fallbackData = uniqueImageData()
        let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .success(fallbackData))
        expect(sut: sut, toCompleteWith: .success(fallbackData))
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
    
    private func expect(sut: FeedImageDataLoader, toCompleteWith expectedResult: FeedImageDataLoader.Result, file: StaticString = #file, line: UInt = #line) {
        let url = URL(string: "http://any-url.com")!
        let exp = expectation(description: "Wait for load image data")
        _ = sut.loadImageData(from: url) { (receivedResult) in
            switch (expectedResult, receivedResult) {
            case (let .success(expectedData), let .success(receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    private func uniqueImageData() -> Data {
        return Data("any data".utf8)
    }
}
