//
//  Session.swift
//  GitHubViewer
//
//  Created by home on 2021/02/26.
//

import Foundation

final class Session {
    private let additionalHeaderFields: () -> [String: String]?
    private let session: URLSession
    
    init(additionalHeaderFields: @escaping () -> [String: String]? = { nil }, session: URLSession = .shared) {
        self.additionalHeaderFields = additionalHeaderFields
        self.session = session
    }
    
}

enum SessionError: Error {
    case noData(HTTPURLResponse)
    case noResponse
    case unacceptableStatusCode(Int, Message?)
    case failedToCreateComponents(URL)
    case failedToCreateURL(URLComponents)
}

extension SessionError {
    struct Message: Decodable {
        let documentationURL: URL
        let message: String
        
        private enum CodingKeys: String, CodingKey {
            case documentationURL = "documentation_url"
            case message
        }
    }
}
