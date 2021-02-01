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
    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        self.primary = primary
    }
    
    class FeedImageDataLoaderWithFallbackDataLoaderTask: FeedImageDataLoaderTask {
        func cancel() {
             
        }
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        primary.loadImageData(from: url) { (result) in
            completion(result)
        }
        return FeedImageDataLoaderWithFallbackDataLoaderTask()
    }
}

class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase {
    func test_loadImageData_deliversPrimaryImageDataOnPrimaryLoaderSuccess() {
        let primaryData = uniqueImageData()
        let primary = ImageDataLoaderStub(result: .success(primaryData))
        let fallback = ImageDataLoaderStub(result: .success(uniqueImageData()))
        let sut = FeedImageDataLoaderWithFallbackComposite(primary: primary, fallback: fallback)
        
        let url = URL(string: "http://any-url.com")!
        let exp = expectation(description: "Wait for load image data")
        _ = sut.loadImageData(from: url) { (result) in
            switch result {
            case let .success(receivedData):
                XCTAssertEqual(primaryData, receivedData)
            default:
                XCTFail("Expected \(primaryData), got \(result) instead")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    private func uniqueImageData() -> Data {
        return Data("any data".utf8)
    }
}
