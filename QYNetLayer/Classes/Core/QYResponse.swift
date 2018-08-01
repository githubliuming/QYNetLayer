//
//  QYResponse.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public struct QYResponse: QYResponseProtocol {
    public var msgId: Int = 0
    public var tag: Int = 0
    public var error: ApiError = ApiError.None
    public var response: Any?
}
