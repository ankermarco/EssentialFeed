//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Ke Ma on 08/10/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import Foundation

var anyNSError: NSError {
    NSError(domain: "any error", code: 0)
}

var anyURL: URL {
    URL(string: "http://any-url.com")!
}
