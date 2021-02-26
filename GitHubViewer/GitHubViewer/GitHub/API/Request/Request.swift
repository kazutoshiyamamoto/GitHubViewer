//
//  Request.swift
//  GitHubViewer
//
//  Created by home on 2021/02/26.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var method: HttpMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var queryParameters: [String: String]? { get }
}


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
