//
//  SearchUsersRequest.swift
//  GitHubViewer
//
//  Created by home on 2021/03/01.
//

import Foundation

struct SearchUsersRequest: Request {
    typealias Response = ItemsResponse<User>
    
    let method: HttpMethod = .get
    let path = "/search/users"
    
    var queryParameters: [String: String]? {
        let params: [String: String] = ["q": query]
        return params
    }
    
    let query: String
    
    init(query: String) {
        self.query = query
    }
}
