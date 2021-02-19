//
//  SceneDelegate.swift
//  EssentialApp
//
//  Created by Valentin Kalchev (Zuant) on 18/01/21.
//

import UIKit
import CoreData
import Feed
import FeediOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    
/*
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let url = URL(string: "https://static1.squarespace.com/static/5891c5b8d1758ec68ef5dbc2/t/5d1c78f21e661a0001ce7cfd/1562147059075/feed-case-study-v1-api-feed.json")!
        let session = URLSession(configuration: .ephemeral)
        let client = URLSessionHTTPClient(session: session)
        let remoteFeedLoader = RemoteFeedLoader(url: url, client: client)
        let remoteFeedImageDataLoader = RemoteFeedImageDataLoader(client: client)
        
        let localStoreURL = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite")
        let localStore = try! CoreDataFeedStore(storeURL: localStoreURL)
        let localFeedLoader = LocalFeedLoader(store: localStore, currentDate: Date.init)
        let localImageLoader = LocalFeedImageDataLoader(store: localStore)
         
        window?.rootViewController = FeedUIComposer.feedComposedWith(feedLoader: FeedLoaderWithFallbackComposite(
                                                                        primary: FeedLoaderCacheDecorator(decoratee: remoteFeedLoader, cache: localFeedLoader),
                                                                        fallback: localFeedLoader),
                                                                     
                                                                 imageLoader: FeedImageDataLoaderWithFallbackComposite(
                                                                    primary: localImageLoader,
                                                                    fallback: remoteFeedImageDataLoader))
    }
 */
}

