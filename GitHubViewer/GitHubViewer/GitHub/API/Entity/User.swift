//
//  User.swift
//  GitHubViewer
//
//  Created by home on 2021/02/25.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
    init(login: String, avatarURL: URL) {
        self.login = login
        self.avatarURL = avatarURL
    }
}
