//
//  QYResponse.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public struct QYResponse: QYResponseProtocol {
    public var temporaryURL: URL?

    public var destinationURL: URL?

    public var resumeData: Data?

    public var data: Data?
    public var progress: Progress?
    public var reqeust: QYRequestProtocol?
    public var error: ApiError = ApiError.None
    public var response: HTTPURLResponse?
    public var responseObj: Any?
}
