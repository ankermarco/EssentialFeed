//
//  FeedCacheTestsHelpers.swift
//  EssentialFeedTests
//
//  Created by Ke Ma on 08/10/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import Foundation
import EssentialFeed

var uniqueImage: FeedImage {
    FeedImage(id: UUID(), description: "", location: "", url: anyURL)
}

var uniqueImageFeed: (models: [FeedImage], local: [LocalFeedImage]) {
    let models = [uniqueImage, uniqueImage]
    let local = models.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    return (models, local)
}

extension Date {
    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -7)
    }
    
    func adding(days: Int) -> Date {
        Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: TimeInterval) -> Date {
        self + seconds
    }
}
