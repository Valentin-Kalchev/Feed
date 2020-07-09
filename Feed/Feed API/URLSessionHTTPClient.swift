//
//  URLSessionHTTPClient.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 18/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
//        let configuration = URLSessionConfiguration.default
//        configuration.waitsForConnectivity = true
//        configuration.timeoutIntervalForResource = 600
//        URLSession(configuration: configuration)
         
        self.session = session
    }
    
    private struct UnexpectedValueRepresentation: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValueRepresentation()))
            }
        }.resume()
    }
}
