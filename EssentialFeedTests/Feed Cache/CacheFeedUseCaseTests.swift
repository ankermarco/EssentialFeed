//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Ke Ma on 15/09/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import EssentialFeed
import XCTest

class LocalFeedLoader {
    private let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed()
    }
}
class FeedStore {
    private(set) var deleteCachedFeedCallCount = 0
    
    func deleteCachedFeed() {
        deleteCachedFeedCallCount += 1
    }
}
class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
    
    func test_save_requestsCacheDeletion() {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        let items = [uniqueItem, uniqueItem]
        sut.save(items)
        XCTAssertEqual(store.deleteCachedFeedCallCount, 1)
    }
    
    private var anyURL: URL {
        URL(string: "http://any-url.com")!
    }
    
    private var uniqueItem: FeedItem {
        FeedItem(id: UUID(), description: "", location: "", imageURL: anyURL)
    }
}
