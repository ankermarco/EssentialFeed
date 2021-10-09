//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Ke Ma on 09/10/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import Foundation

final class FeedCachePolicy {
    private init() {}
    private static let calendar = Calendar(identifier: .gregorian)
    private static let maxCacheAgeInDays = 7

    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        return date < maxCacheAge
    }
}
