//
//  Localized.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 16/12/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

public final class Localized {
    static var bundle: Bundle {
        return Bundle(for: Localized.self)
    }
}

public extension Localized {
    enum Feed {
        public static var table: String { "Feed" }
        public static var title: String {
            NSLocalizedString("FEED_VIEW_TITLE",
                              tableName: table,
                              bundle: bundle,
                              comment: "Title for the feed view")
        }
        
        public static var loadError: String {
            return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR",
                                     tableName: table,
                                     bundle: bundle,
                                     comment: "Error message displayed when we cannot load the image feed from the server")
        }
    }
}
