//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Ke Ma on 05/12/2020.
//  Copyright © 2020 Ke Ma. All rights reserved.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
