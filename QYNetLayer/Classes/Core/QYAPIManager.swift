//
//  QYAPIManager.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public class QYAPIManager: NSObject {
    private var taskArray: Array<QYTaskProtocol> = Array<QYTaskProtocol>.init()
    
    private var apiCenter:QYNetCenter = QYNetCenter.init()
    weak var delegate: QYHttpDelegate?
    public override init() {
        super.init()
        apiCenter.delegate = self
    }
    @discardableResult
    public func startRuqest(_ request: QYRequestProtocol) -> QYTaskProtocol? {
        do {
            let task:QYTask =  try apiCenter.sendRequest(request:request)
            return task
        } catch let error {

            self.errorHandler(error: error as! ApiError)
        }
        return nil
    }

    public func cancel(task: QYTaskProtocol) {
        task.cancel()
        guard let i = self.taskIndex(task: task) else {
            return
        }
        objc_sync_enter(taskArray)
        taskArray.remove(at: i)
        objc_sync_exit(taskArray)
    }

    public func resume(task: QYTaskProtocol) {
        task.resume()
    }

    public func cancelAllInteriorTask() {
        let copyeTaskArray: Array<QYTaskProtocol> = taskArray
        copyeTaskArray.forEach { task in
            self.cancel(task: task)
        }
    }

    public func cancelAll() {
    }

    func taskIndex(task tsk: QYTaskProtocol) -> Int? {
        objc_sync_enter(taskArray)
        var i: Int?
        for (index, value) in taskArray.enumerated() {
            if value.equal(another: tsk) {
                i = index
                break
            }
        }
        objc_sync_exit(taskArray)
        return i
    }
}
extension QYAPIManager:QYNetCenterProtocol{
    public func updateProgress(response: QYResponse) {
        self.delegate?.httpRequestProgress(response: response)
    }
    public func completedHandler(respose: QYResponse) {
        self.delegate?.httpRequestSuccess(response: respose)
    }
    public func errorHandler(error: ApiError) {
      self.delegate?.httpRequestFailure(error: error)
    }
}
