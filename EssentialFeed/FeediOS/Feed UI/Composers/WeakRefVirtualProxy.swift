//
//  WeakRefVirtualProxy.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 23/02/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import Foundation

final class WeakRefVirtualProxy<T: AnyObject> {
    private(set) weak var object:T?
    
    init(_ object: T) {
        self.object = object
    }
}
