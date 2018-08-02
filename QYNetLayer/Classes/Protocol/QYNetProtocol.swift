//
//  QYNetProtocol.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import Foundation

/// http请求
public protocol QYHttpDelegate: NSObjectProtocol {
    func httpRequestSuccess(response: QYResponseProtocol)
    func httpRequestFailure(error: ApiError)
    func httpRequestProgress(response: QYResponseProtocol)
}

public protocol QYResponseProtocol {
    var msgId: Int { get set }
    var tag: Int { get set }
    var error: ApiError { get set }
    var response: Any? { get set }
}

public protocol QYRequestProtocol {
    init(baseUrl url: String?)
    init(apiPath path: String?)
    
    /// 接口路径
    var apiPath: String? { get set }

    ///  请求url，当url有值且全局配置的BaseUrl也有值 并且ingoreBaseUrl为NO的情况下以全局配置的url为准
    var url: String? { get set }

    /// 接口完整路径 baseUrl + api
    var fullUrl: String? { get set }

    /// 完整的请求Url baseUrl + api + params
    var uriPath: String? { get set }

    /// 超时时间
    var timeOutInterval: TimeInterval { get set }

    /// 是否忽略全局配置的 httpHeader 默认 false 不忽略
    var ingoreGloableHeaders: Bool { get set }

    /// 本次请求是否忽略默认配置的请求参数 默认为NO 不忽略
    var ingoreGloableParams: Bool { get set }

    /// 文件路径
    var fileUrl: String? { get set }

    /// 参数
    var params: Dictionary<String, Any> { get set }

    /// 自定义头部
    var headers: Dictionary<String, String> { get set }

    /// 混存策略
    var cachePolicy: URLRequest.CachePolicy { get set }

    /// 消息ID
    var msgId: Int { get set }

    /// 消息tag
    var tag: Int { get set }

    /// 请求类型
    var requstType: QYRequestType { get set }

    /// HttpMethod
    var httpMethod: QYHttpMethod { get set }

    /// 是否支持断点续传 默认 true
    var supportBreakpoint: Bool { get set }

    /// 重试次数 默认 3次
    var retryCount: Int { get set }

    /// 重试间隔 0.2s
    var retryDelayTime: TimeInterval { get set }

    /// 是否允许重复请求
    var allowRepeatRequest: Bool { get set }

    /// 请求任务优先级
    var taskPrority: QYTaskPriority { get set }
}

public protocol QYTaskProtocol {
    var msgId: Int { get set }
    var tag: Int { get set }
    func cancel()
    func resume()
    func pause()
    func equal(another task: QYTaskProtocol) -> Bool
}

public protocol QYPlugsProtocol {
    associatedtype inputType
    associatedtype outputType
    
    func setInputData(in data: inputType)
    func getOutputData() throws -> outputType?
}
