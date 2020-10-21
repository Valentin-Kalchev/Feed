//
//  FeedViewController.swift
//  FeediOS
//
//  Created by Valentin Kalchev (Zuant) on 21/10/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import UIKit
import Feed

public final class FeedViewController: UITableViewController {
    private var loader: FeedLoader?
    
    public convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        load()
    }
    
    @objc private func load() {
        refreshControl?.beginRefreshing()
        loader?.load { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
    }
}
