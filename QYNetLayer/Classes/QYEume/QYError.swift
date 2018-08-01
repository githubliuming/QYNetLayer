//
//  QYError.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import Foundation

public enum ApiError:Swift.Error {
    case None
    case urlValidError(error:Swift.Error)
    case APIRequestNilError
}

public enum QYRequestType: Int {
    case normal = 0
    case upload = 1
    case download = 2
}

public enum QYHttpMethod: String {
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

public enum QYTaskPriority:Int{
    case low = 0
    case defualt = 1
    case high = 2
}
