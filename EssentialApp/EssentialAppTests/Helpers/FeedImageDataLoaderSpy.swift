//
//  FeedImageDataLoaderSpy.swift
//  EssentialAppTests
//
//  Created by Valentin Kalchev (Zuant) on 04/02/21.
//

import Foundation
import Feed

class FeedImageDataLoaderSpy: FeedImageDataLoader {
    private(set) var messages = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
    private(set) var cancelledURL = [URL]()
    
    var loadedURLs: [URL] {
        return messages.map { $0.url }
    }
    
    private struct Task: FeedImageDataLoaderTask {
        let callback: () -> Void
        func cancel() {
            callback()
        }
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        messages.append((url, completion))
        
        return Task { [weak self] in
            self?.cancelledURL.append(url)
        }
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
    
    func complete(with data: Data, at index: Int = 0) {
        messages[index].completion(.success(data))
    }
}
