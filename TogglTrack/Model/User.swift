//
//  User.swift
//  TogglWatch WatchKit Extension
//
//  Created by Juxhin Bakalli on 14/11/19.
//  Copyright © 2019 Toggl. All rights reserved.
//

import Foundation

public struct User: Codable, Equatable
{
    var id: Int
    var apiToken: String
    
    enum CodingKeys: String, CodingKey
    {
        case id
    
        case apiToken = "api_token"
    }
}
