//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Ke Ma on 01/09/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
