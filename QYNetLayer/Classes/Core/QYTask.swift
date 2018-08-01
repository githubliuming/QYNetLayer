//
//  QYTask.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public struct QYTask: QYTaskProtocol {
    private var urlTask: URLSessionTask

    public var msgId: Int = 0
    public var tag: Int = 0

    public func cancel() {
        urlTask.cancel()
    }

    public func resume() {
        urlTask.resume()
    }

    public func pause() {
        urlTask.suspend()
    }

    public func equal(another task: QYTaskProtocol) -> Bool {
        return (msgId == task.msgId && tag == task.tag)
    }

    public init(task: URLSessionTask) {
        urlTask = task
    }
}
