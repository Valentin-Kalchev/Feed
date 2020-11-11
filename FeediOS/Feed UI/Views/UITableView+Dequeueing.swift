//
//  UITableView+Dequeueing.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 11/11/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
