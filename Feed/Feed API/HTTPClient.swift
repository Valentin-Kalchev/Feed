//
//  HTTPClient.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 16/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation


public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
