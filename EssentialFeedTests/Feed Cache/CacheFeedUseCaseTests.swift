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
    private(set) var insertCallCount = 0
    
    func deleteCachedFeed() {
        deleteCachedFeedCallCount += 1
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        
    }
}
class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let (store, _) = makeSUT()
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
    
    func test_save_requestsCacheDeletion() {
        let (store, sut) = makeSUT()
        let items = [uniqueItem, uniqueItem]
        sut.save(items)
        XCTAssertEqual(store.deleteCachedFeedCallCount, 1)
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeletionError() {
        let (store, sut) = makeSUT()
        let items = [uniqueItem, uniqueItem]
        sut.save(items)
        let deletionError = anyNSError
        store.completeDeletion(with: deletionError)
        XCTAssertEqual(store.insertCallCount, 0)
    }
    
    // MARK: - Helpers
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (FeedStore, LocalFeedLoader) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (store, sut)
    }
    
    private var anyURL: URL {
        URL(string: "http://any-url.com")!
    }
    
    private var anyNSError: NSError {
        NSError(domain: "any error", code: 0)
    }
    
    private var uniqueItem: FeedItem {
        FeedItem(id: UUID(), description: "", location: "", imageURL: anyURL)
    }
}
