//
//  ValidateFeedCacheUseCase.swift
//  EssentialFeedTests
//
//  Created by Ke Ma on 08/10/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import XCTest
import EssentialFeed

class ValidateFeedCacheUseCase: XCTestCase {

    func test_init_doesNotMessageStoreUponCreation() {
        let (store, _) = makeSUT()
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_validateCache_deletesCacheOnRetrievalError() {
        let (store, sut) = makeSUT()
        
        sut.validateCache()
        store.completeRetrieval(with: anyNSError)
        
        XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
    }
    
    // MARK: - Helpers
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (FeedStoreSpy, LocalFeedLoader) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (store, sut)
    }
    
    private var anyNSError: NSError {
        NSError(domain: "any error", code: 0)
    }

}
