//
//  UserAction.swift
//  TogglWatch
//
//  Created by Juxhin Bakalli on 15/11/19.
//  Copyright © 2019 Toggl. All rights reserved.
//

import Foundation

public enum LoginAction
{
    case login(String, String)
    case getLoginWithAppleToken
    case loginWithApple(String)
    case setUser(User)
    case loadAPITokenAndUser
    case logout
    case subscribeToPushNotifications(String)
    case subscribedToPushNotifications(FCMPushToken)
}
