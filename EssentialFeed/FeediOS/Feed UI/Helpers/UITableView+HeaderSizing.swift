//
//  UITableView+HeaderSizing.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 24/02/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import UIKit

extension UITableView {
    func sizeTableHeaderToFit() {
        guard let header = tableHeaderView else { return }
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        let needsFrameUpdate = header.frame.height != size.height
        if needsFrameUpdate {
            header.frame.size.height = size.height
            tableHeaderView = header
        }
    }
}
