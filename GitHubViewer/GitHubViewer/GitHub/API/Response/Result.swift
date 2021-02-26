//
//  Result.swift
//  GitHubViewer
//
//  Created by home on 2021/02/26.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
