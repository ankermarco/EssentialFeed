//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Ke Ma on 03/10/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
}
