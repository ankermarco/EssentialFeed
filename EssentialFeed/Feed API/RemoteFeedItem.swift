//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Ke Ma on 03/10/2021.
//  Copyright © 2021 Ke Ma. All rights reserved.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
