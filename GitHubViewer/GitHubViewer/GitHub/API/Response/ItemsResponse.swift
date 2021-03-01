//
//  ItemsResponse.swift
//  GitHubViewer
//
//  Created by home on 2021/02/26.
//

import Foundation

struct ItemsResponse<Item: Decodable>: Decodable {
    let items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
}
