//
//  FeedImageCell.swift
//  FeediOSTests
//
//  Created by Valentin Kalchev (Zuant) on 23/10/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
    
    @IBOutlet private(set) public var locationContainer: UIView!
    @IBOutlet private(set) public var locationLabel: UILabel!
    @IBOutlet private(set) public var descriptionLabel: UILabel!
    @IBOutlet private(set) public var feedImageContainer: UIView!
    @IBOutlet private(set) public var feedImageView: UIImageView!
    @IBOutlet private(set) public var feedImageRetryButton: UIButton!
    
    var onRetry: (() -> Void)?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessibilityIdentifier = "feed-image-cell"
        feedImageView.accessibilityIdentifier = "feed-image-view"
    }
    
    @IBAction private func retryButtonTapped() {
        onRetry?()
    }
}
