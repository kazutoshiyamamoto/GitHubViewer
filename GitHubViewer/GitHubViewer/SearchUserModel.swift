//
//  SearchUserModel.swift
//  GitHubViewer
//
//  Created by home on 2021/10/01.
//

import Foundation

protocol SearchUserModelInput {
    func fetchUser(
        query: String,
        completion: @escaping (Result<[User]>) -> ())
}

final class SearchUserModel: SearchUserModelInput {
    
}
