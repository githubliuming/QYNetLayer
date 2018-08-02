//
//  QYBridgeNet.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import Alamofire
import UIKit

// public typealias Manager = Alamofire.SessionManager
// public typealias Request = Alamofire.Request
// internal typealias DownloadRequest = Alamofire.DownloadRequest
// internal typealias UploadRequest = Alamofire.UploadRequest
// internal typealias DataRequest = Alamofire.DataRequest

public class QYBridgeNet: NSObject {
    public static var `default` = QYBridgeNet()

//    public var manager:SessionManager = SessionManager.default;

    private override init() {
        super.init()
    }

    public func send(request: QYRequestProtocol) -> QYTask {
        return qy_send(rq: request)
    }

    private func qy_send(rq: QYRequestProtocol) -> QYTask {
        // 1.将 QYRequestProtocol 转换成 urlRequest
        let plug = QYNetPlugsManager.default.plug(key:.convertRquest)
        
//        Alamofire.request(<#T##url: URLConvertible##URLConvertible#>)
//        task.resume()
        return QYTask(task: URLSessionTask.init())
    }

    private func getHttpMethod(method: QYHttpMethod) -> HTTPMethod {
        switch method {
        case .get:
            return HTTPMethod.get
        case .delete:
            return HTTPMethod.delete
        case .head:
            return HTTPMethod.head
        case .patch:
            return HTTPMethod.patch
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        }
    }
}
