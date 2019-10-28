//
//  User.swift
//  GithubUsersStars
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

struct Result: Decodable {
    let items: [User]?
    let totalCount:Int?
    
    enum CodingKeys:String, CodingKey {
        case items
        case totalCount = "total_count"
    }
}

struct User: Decodable {
    let id: Int?
    let name: String?
    let stargazers_count: Int?
    let owner: Owner?
}

struct Owner: Decodable {
    let login: String?
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
