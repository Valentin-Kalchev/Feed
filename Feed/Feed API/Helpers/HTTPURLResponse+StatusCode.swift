//
//  HTTPURLResponse+StatusCode.swift
//  Feed
//
//  Created by Valentin Kalchev (Zuant) on 12/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
