//
//  XCTestCase+MemoryLeaksTracker.swift
//  EssentialFeedTests
//
//  Created by Ke Ma on 02/09/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        // After running each test function, the teardownBlock is invoked
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
