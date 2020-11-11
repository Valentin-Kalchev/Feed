//
//  UIImageView+Animations.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 11/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        guard newImage != nil else { return }
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
