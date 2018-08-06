//
//  QYBridgeNet.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import Alamofire
import UIKit

public typealias QYProgressHandler = (_ response: QYResponse) -> Void
public typealias QYCompletionHandler = (_ response: QYResponse) -> Void

public class QYBridgeNet: NSObject {

    //MARK - 结果序列化对象
    
    public static var `default` = QYBridgeNet()
    public var manager: SessionManager = SessionManager.default

    private override init() {
        super.init()
    }

    public func send(request: QYRequestProtocol,
                     progress: @escaping QYProgressHandler,
                     completed: @escaping QYCompletionHandler) throws -> QYTask {
        do {
            var task: QYTask?
            switch request.requstType {
            case .normal:
                task = try qy_dataTask(rq: request,
                                       progress: progress,
                                       completed: completed)
            case .download:
                task = try qy_downTask(rq: request,
                                       progress: progress,
                                       completed: completed)
            case .upload:
                task = try qy_uploadTask(rq: request,
                                         progress: progress,
                                         completed: completed)
            }
            return task!
        } catch let error {
            throw error
        }
    }

    private func qy_dataTask(rq: QYRequestProtocol,
                             progress: @escaping QYProgressHandler,
                             completed: @escaping QYCompletionHandler) throws -> QYTask {
        let requestPlug: QYRequestConvertPlug = QYRequestConvertPlug()
      let paramEncoderPlug:QYParamEcodingPlug = QYParamEcodingPlug.init()
        requestPlug.setInputData(in: rq)
        do {
            let request: URLRequest? = try requestPlug.getOutputData()

            guard let tmpRequest = request else {
                throw ApiError.APIRequestNilError
            }
		paramEncoderPlug.setInputData(in: (tmpRequest, rq.params, rq.requestSerializerType))
            let encoderRuquest:URLRequest? = try paramEncoderPlug.getOutputData()
            var dataTask: DataRequest = Alamofire.request(encoderRuquest!)
            dataTask = bind(dataTask, request: rq,
                            progressHandler: progress,
                            completed: completed)

            dataTask.resume()
            return QYTask(task: dataTask.task!)

        } catch let error {
            throw error
        }
    }
    private func qy_downTask(rq: QYRequestProtocol,
                             progress: @escaping QYProgressHandler,
                             completed: @escaping QYCompletionHandler) throws -> QYTask {
        let requestPlug: QYRequestConvertPlug = QYRequestConvertPlug()
        requestPlug.setInputData(in: rq)
        do {
            let request: URLRequest? = try requestPlug.getOutputData()

            guard let tmpRequest = request else {
                throw ApiError.APIRequestNilError
            }
            var dataTask = Alamofire.download(tmpRequest, to: { (url, _) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
                (destinationURL: url, options: [])
            })
            dataTask = bind(dataTask, request: rq, progressHandler: progress, completed: completed)
            return QYTask(task: dataTask.task!)

        } catch let error {
            throw error
        }
    }

    private func qy_uploadTask(rq _: QYRequestProtocol,
                               progress _: @escaping QYProgressHandler,
                               completed _: @escaping QYCompletionHandler) throws -> QYTask {
        
        return QYTask(task: URLSessionTask())
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

extension QYBridgeNet {
    @discardableResult
    public func bind<T>(_ taskRequest: T,
                        request: QYRequestProtocol,
                        progressHandler: @escaping QYProgressHandler,
                        completed: @escaping QYCompletionHandler) -> T {
        let callBack: DispatchQueue = QYNetGlobalConfig.default.callBackQueue
        var resultTask: T = taskRequest
        switch taskRequest {
        case let dataTask as DataRequest:
            dataTask.downloadProgress(queue: callBack) { progress in
                var response: QYResponse = QYResponse()
                response.reqeust = request
                response.progress = progress
                progressHandler(response)
            }
            dataTask.response(queue: callBack) { handler in
                var response: QYResponse = QYResponse()
                response.reqeust = request
                response.error = ApiError.httpResonseError(error: handler.error)
                response.response = handler.response
                response.data = handler.data
                completed(response)
            }
            resultTask = dataTask as! T
        case let downLoadTask as DownloadRequest:
            downLoadTask.downloadProgress(queue: callBack) { progress in
                var response: QYResponse = QYResponse()
                response.reqeust = request
                response.progress = progress
                progressHandler(response)
            }
            downLoadTask.response(completionHandler: { handler in
                var response: QYResponse = QYResponse()
                response.reqeust = request
                response.error = ApiError.httpResonseError(error: handler.error)
                response.response = handler.response
                completed(response)
            })
            resultTask = downLoadTask as! T
        case let uploadTask as UploadRequest:
            uploadTask.uploadProgress(queue: callBack, closure: { progress in
                var response: QYResponse = QYResponse()
                response.reqeust = request
                response.progress = progress
                progressHandler(response)
            })
            uploadTask.response(queue: callBack, completionHandler: { handler in
                var response: QYResponse = QYResponse()
                response.reqeust = request
                response.error = ApiError.httpResonseError(error: handler.error)
                response.response = handler.response
                response.data = handler.data
                completed(response)
            })
            resultTask = uploadTask as! T
        default:
            break
        }
        return resultTask
    }
}
