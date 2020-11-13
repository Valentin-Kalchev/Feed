//
//  UIButton+TestHelpers.swift
//  FeediOSTests
//
//  Created by Valentin Kalchev (Zuant) on 13/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach({ (target) in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach({ (action) in
                (target as NSObject).perform(Selector(action))
            })
        })
    }
}
