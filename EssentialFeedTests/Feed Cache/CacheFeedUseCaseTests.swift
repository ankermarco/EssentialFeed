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
    private let currentDate: () -> Date
    
    init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed { [unowned self] error in
            if error == nil {
                self.store.insert(items, timestamp: self.currentDate())
            }
        }
    }
}
class FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    private(set) var deleteCachedFeedCallCount = 0
    var insertions = [(items: [FeedItem], timestamp: Date)]()
    
    private var deletionCompletions = [DeletionCompletion]()
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        deleteCachedFeedCallCount += 1
        deletionCompletions.append(completion)
    }
    
    func insert(_ items: [FeedItem], timestamp: Date) {
        insertions.append((items: items, timestamp: timestamp))
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deletionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deletionCompletions[index](nil)
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
        XCTAssertEqual(store.insertions.count, 0)
    }
    
    func test_save_requestsNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
        let timestamp = Date()
        let (store, sut) = makeSUT(currentDate: { timestamp })
        let items = [uniqueItem, uniqueItem]
        sut.save(items)
        
        store.completeDeletionSuccessfully()
        
        XCTAssertEqual(store.insertions.count, 1)
        XCTAssertEqual(store.insertions.first?.items, items)
        XCTAssertEqual(store.insertions.first?.timestamp, timestamp)
    }
    
    // MARK: - Helpers
    func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (FeedStore, LocalFeedLoader) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
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
