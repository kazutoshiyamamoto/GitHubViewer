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
    func fetchUser(
        query: String,
        completion: @escaping (Result<[User]>) -> ()) {
        
        let request = SearchUsersRequest(query: query)
        
        Session().send(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
