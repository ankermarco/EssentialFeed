//
//  LocalFeedItem.swift
//  EssentialFeed
//
//  Created by Ke Ma on 03/10/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import Foundation

public struct LocalFeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
