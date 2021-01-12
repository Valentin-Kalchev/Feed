//
//  URLSessionHTTPClient.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 18/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValueRepresentation: Error {}
    
    private struct URLSessionTaskMapper: HTTPClientTask {
        let wrapped: URLSessionTask
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValueRepresentation()
                }
            })
        }
        
        task.resume()
        return URLSessionTaskMapper(wrapped: task)
    }
}
