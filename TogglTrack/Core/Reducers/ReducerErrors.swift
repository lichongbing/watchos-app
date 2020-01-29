//
//  Errors.swift
//  TogglWatch
//
//  Created by Juxhin Bakalli on 21/11/19.
//  Copyright © 2019 Toggl. All rights reserved.
//

import Foundation

public enum TimelineError: Error
{
    case CantFindTimeEntry
    case NoRunningEntry
}

public enum UserError: Error
{
    case NoFCMResponse
    case FailedToGetFCMToken(String?)
    case NoFCMTokenAvailable
}
