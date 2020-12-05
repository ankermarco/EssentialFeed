//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Ke Ma on 05/12/2020.
//  Copyright © 2020 Ke Ma. All rights reserved.
//

import XCTest
class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}
class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        XCTAssertNil(client.requestedURL)
    }

}
