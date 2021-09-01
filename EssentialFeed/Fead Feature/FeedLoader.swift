//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Ke Ma on 05/12/2020.
//  Copyright © 2020 Ke Ma. All rights reserved.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
